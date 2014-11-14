var Bcrypt, Crypto, Promise;

Crypto = require('crypto');

Bcrypt = require("bcryptjs");

Promise = require("bluebird");

module.exports = (function() {
  var helper;
  helper = {};
  helper.generateShortLink = function(length) {
    return new Promise(function(resolve, reject) {
      var result;
      length = length || 12;
      result = helper.randomValueBase64(length);
      return resolve(result);
    });
  };
  helper.randomValueBase64 = function(length) {
    return Crypto.randomBytes(Math.ceil(length * 3 / 4)).toString('base64').slice(0, length).replace(/\+/g, '0').replace(/\//g, '0');
  };
  helper.generateUserPassword = function(password) {
    return new Promise(function(resolve, reject) {
      return Bcrypt.hash(password, 8, function(err, encryptedPassword) {
        if (err) {
          return reject();
        }
        return resolve(encryptedPassword);
      });
    });
  };
  return helper;
})();
