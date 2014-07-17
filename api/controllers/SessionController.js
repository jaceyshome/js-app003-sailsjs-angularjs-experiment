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
        user.online = true;
        user.save(function(err,user){
          if(err){
            return next(err);
          }
          res.json(user);
        });
        res.json({id:user.id});
      });
    });
  },

  destroy: function(req, res, next) {
    if(!req.session.User){
      req.session.destroy();
      res.json("1");
      return;
    }
    User.update(req.session.User.id, {
      online: false
    },function userUpdated(err) {
      if (err) {
        return next(err);
      }
      req.session.destroy();
      res.json("1");
    });
  }
};