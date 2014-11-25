var Bcrypt, Crypto, Promise;

Crypto = require('crypto');

Bcrypt = require("bcrypt-nodejs");

Promise = require("bluebird");

module.exports = (function() {
  var helper;
  helper = {};
  helper.generateShortLink = function(length) {
    return new Promise(function(resolve, reject) {
      var result;
      length = length || 24;
      result = helper.randomValueBase64(length);
      return resolve(result);
    });
  };
  helper.randomValueBase64 = function(length) {
    return Crypto.randomBytes(Math.ceil(length * 3 / 4)).toString('base64').slice(0, length).replace(/\+/g, '0').replace(/\//g, '0');
  };
  helper.generateUserPassword = function(password) {
    return new Promise(function(resolve, reject) {
      return Bcrypt.hash(password, null, null, function(err, hash) {
        if (err) {
          return reject();
        }
        return resolve(hash);
      });
    });
  };
  helper.checkUserPassword = function(user) {
    return new Promise(function(resolve, reject) {
      var query;
      query = "SELECT id, shortLink, name, password FROM users WHERE id = " + user.id + " AND shortLink = '" + user.shortLink + "'";
      return User.query(query, function(err, result) {
        if (result.length !== 1) {
          return resolve(false);
        }
        if (result[0].id === user.id && result[0].shortLink === user.shortLink) {
          return resolve(result[0]);
        }
        return resolve(false);
        return Bcrypt.compare(user.password, result[0].password, function(err, res) {
          if (err) {
            resolve(false);
          }
          return resolve(res);
        });
      });
    });
  };
  helper.checkUserExists = function(user) {
    return new Promise(function(resolve, reject) {
      var query;
      if (!user.id) {
        return reject(null);
      }
      if (!user.shortLink) {
        return reject(null);
      }
      query = "SELECT id, shortLink, name, password FROM users WHERE id = " + user.id + " AND shortLink = '" + user.shortLink + "'";
      return User.query(query, function(err, result) {
        if ((result != null ? result.length : void 0) !== 1) {
          return resolve(false);
        }
        if (result[0].id === user.id && result[0].shortLink === user.shortLink) {
          return resolve(result[0]);
        }
        return resolve(false);
      });
    });
  };
  helper.checkProjectExists = function(project) {
    return new Promise(function(resolve, reject) {
      var query;
      if (!project.id) {
        return reject(null);
      }
      if (!project.shortLink) {
        return reject(null);
      }
      query = "SELECT id, shortLink, name FROM projects WHERE id = " + project.id + " AND shortLink = '" + project.shortLink + "'";
      return Project.query(query, function(err, result) {
        if (result.length !== 1) {
          return resolve(false);
        }
        if (result[0].id === project.id && result[0].shortLink === project.shortLink) {
          return resolve(result[0]);
        }
        return resolve(false);
      });
    });
  };
  return helper;
})();
