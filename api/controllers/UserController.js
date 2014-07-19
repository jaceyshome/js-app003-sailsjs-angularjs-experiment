/**
 * UserController
 *
 * @module      :: Controller
 * @description	:: A set of functions called `actions`.
 *
 *                 Actions contain code telling Sails how to respond to a certain type of request.
 *                 (i.e. do stuff, then send some JSON, show an HTML page, or redirect to another URL)
 *
 *                 You can configure the blueprint URLs which trigger these actions (`config/controllers.js`)
 *                 and/or override them with custom routes (`config/routes.js`)
 *
 *                 NOTE: The code you write here supports both HTTP and Socket.io automatically.
 *
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */
module.exports = (function(){
  var ctrl = {};

  ctrl.create = function(req,res,next){
    User.create(req.params.all(), function userCreated(err, user){
      if(err){
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
        User.publishUpdate(user.id,{
          loggedIn: true,
          id:user.id
        });
        res.json(user);
      });
    });
  };

  ctrl.specifics = function(req,res,next){
    User.findOne(req.param('id'), function foundUser(err, user){
      if(err || !user){return next(err);}
      res.json(user);
    });
  };

  ctrl.all = function(req,res,next){
    User.find(function foundUsers(err, users){
      if(err || !users){return next(err);}
      res.json(users);
    })
  };

  ctrl.update = function(req, res, next) {
    //TODO update userObj
    var userObj = {
      name: req.param('name'),
      email: req.param('email')
    };
    User.update(req.param('id'), userObj, function userUpdated(err) {
      if (err) {
        return next(err);
      }
      res.json("1");
    });
  };

  ctrl.destroy = function(req,res,next){
    User.findOne(req.param('id'), function userDestroyed(err,user){
      if(err){ return next(err); }
      if(!user){return next("User doesn\'t exist.");}
      User.destroy(req.param('id'), function userDestroyed(err){
        if(err){ return next(err); }
      });
      res.json('1');
    });
  };

  ctrl.subscribe = function(req, res) {
    // Find all current users in the user model
    User.find(function foundUsers(err, users) {
      if (err) return next(err);
      // subscribe this socket to the User model classroom
      User.subscribe(req.socket);
      // subscribe this socket to the user instance rooms
      User.subscribe(req.socket, users);
      // This will avoid a warning from the socket for trying to render
      // html over the socket.
      res.send(200);
    });
  };
  ctrl._config = {};

  return ctrl;
})();
