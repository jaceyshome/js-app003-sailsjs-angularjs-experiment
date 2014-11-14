var CommonHelper, Promise;

CommonHelper = require('../helpers/Common');

Promise = require("bluebird");

module.exports = (function() {
  var ctrl;
  ctrl = {};
  ctrl.create = function(req, res, next) {
    var userCreated;
    return User.create(req.params.all(), userCreated = function(err, user) {
      if (err) {
        return next(err);
      }
      return user.save(function(err, user) {
        var userJson;
        if (err) {
          return next(err);
        }
        User.publishCreate({
          id: user.id,
          name: user.name,
          online: user.online
        }, req.socket);
        userJson = {
          id: user.id,
          name: user.name,
          email: user.email,
          shortLink: user.shortLink,
          online: user.online
        };
        return res.json(userJson);
      });
    });
  };
  ctrl.specifics = function(req, res, next) {
    return User.findByShortLink(req.param('shortLink')).exec(function(err, user) {
      var userJson;
      if (err || !user) {
        return next(err);
      }
      userJson = {
        id: user[0].id,
        name: user[0].name,
        email: user[0].email,
        shortLink: user[0].shortLink
      };
      return res.json(userJson);
    });
  };
  ctrl.all = function(req, res, next) {
    return User.query("SELECT id, name, email, shortLink FROM users", function(err, users) {
      if (err || !users) {
        return next(err);
      }
      return res.json(users);
    });
  };
  ctrl.update = function(req, res, next) {
    var userObj;
    userObj = {
      email: req.param("email"),
      password: req.param("password")
    };
    return User.update(req.param("id"), userObj, function(err) {
      if (err) {
        return next(err);
      }
      User.publishUpdate(req.param("id"), {
        id: req.param("id"),
        name: req.param("name"),
        email: req.param("email")
      }, req.socket);
      return res.send(200);
    });
  };
  ctrl.destroy = function(req, res, next) {
    var query;
    query = ("DELETE FROM users WHERE id = " + (req.param('id')) + " AND shortLink = '") + ("" + (req.param('shortLink'))) + "'";
    User.query(query, function(err) {
      if (err) {
        return next(err);
      }
      return User.publishDestroy(req.param("id"), req.socket);
    });
    return res.send(200);
  };
  ctrl.subscribe = function(req, res, next) {
    return User.find(function(err, users) {
      if (err) {
        return next(err);
      }
      User.subscribe(req.socket);
      User.subscribe(req.socket, users);
      return res.send(200);
    });
  };
  ctrl._config = {};
  return ctrl;
})();
