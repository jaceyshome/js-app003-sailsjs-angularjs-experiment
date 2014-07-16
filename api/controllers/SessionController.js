/**
 * SessionController
 *
 * @module		:: Controller
 * @description	:: Contains logic for handling requests.
 */
var bcrypt = require('bcryptjs');

module.exports = {
  create: function(req, res, next) {
    if (!req.param('name') || !req.param('password')) {
      console.log("required name or password");
      return next(err);
    }
    User.findOneByName(req.param('name'), function foundUser(err, user) {
      if (err || !user) {
        console.log("User not found");
        return next(err);
      }
      bcrypt.compare(req.param('password'), user.password, function(err, valid) {
        if (err || !valid){
          console.log("Password is wrong.");
          return next(err);
        }
        req.session.cookie.expires = new Date((new Date()).getTime() + 60000);
        req.session.authenticated = true;
        req.session.User = user;
        res.json({id:user.id});
      });
    });
  },

  destroy: function(req, res, next) {
    User.findOne(req.session.User.id, function foundUser(err, user) {
      var userId = req.session.User.id;
      if (user) {
        User.update(userId, {
          online: false
        }, function(err) {
          if (err) return next(err);
          // Inform other sockets (e.g. connected sockets that are subscribed) that the session for this user has ended.
          User.publishUpdate(userId, {
            loggedIn: false,
            id: userId,
            name: user.name,
            action: ' has logged out.'
          });
          // Wipe out the session (log out)
          req.session.destroy();
          // Redirect the browser to the sign-in screen
          res.redirect('/session/new');
        });
      } else {

        // Wipe out the session (log out)
        req.session.destroy();

        // Redirect the browser to the sign-in screen
        res.redirect('/session/new');
      }
    });
  }
};