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

module.exports = {
  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to UserController)
   */
//  "*":true,

  create:function(req,res,next){
    User.create(req.params.all(), function userCreated(err, user){
      if(err){return next(err);}
      res.json(user);
    });
  },
  detail:function(req,res,next){
    User.findOne(req.param('id'), function foundUser(err, user){
      if(err || !user){return next(err);}
      res.json(user);
    });
  },
  list:function(req,res,next){
    User.find(function foundUsers(err, users){
      if(err || !users){return next(err);}
      res.json(users);
    })
  },
  _config: {}

};
