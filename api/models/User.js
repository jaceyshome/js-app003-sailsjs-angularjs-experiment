var CommonHelper, YAML;

YAML = require('yamljs');

CommonHelper = require('../helpers/Common');

module.exports = (function() {
  var checkUserExists, userModel;
  userModel = {};
  userModel.tableName = "users";
  userModel.migrate = "safe";
  userModel.attributes = YAML.load('validations/user.yml');
  delete userModel.attributes.confirmPassword;
  userModel.attributes.password.maxLength = 256;
  userModel.beforeCreate = function(values, next) {
    if (!values.password) {
      return next({
        err: ["Password is required."]
      });
    }
    return CommonHelper.generateShortLink(userModel.attributes.shortLink.maxLength).then(function(result) {
      values.shortLink = result;
      return CommonHelper.generateUserPassword(values.password).then(function(encryptedPassword) {
        values.password = encryptedPassword;
        return next();
      })["catch"](function() {
        return next(err);
      });
    });
  };
  userModel.beforeUpdate = function(values, next) {
    if (!values.password) {
      return next({
        err: ["Password is required."]
      });
    }
    return CommonHelper.generateUserPassword(values.password).then(function(encryptedPassword) {
      values.password = encryptedPassword;
      return next();
    })["catch"](function() {
      return next(err);
    });
  };
  userModel.beforeDestroy = function(values, next) {
    return next();
  };
  checkUserExists = function(user) {
    return new Promise(function(resolve, reject) {
      var query;
      if (!user.id) {
        return reject(null);
      }
      if (!user.shortLink) {
        return reject(null);
      }
      query = "SELECT id, shortLink FROM users WHERE id = " + user.id + " AND shortLink = '" + user.shortLink + "'";
      return User.query(query, function(err, result) {
        console.log("result", result);
        if (result[0].id === user.id && result[0].shortLink === user.shortLink) {
          return resolve(true);
        } else {
          return resolve(false);
        }
      });
    });
  };
  return userModel;
})();
