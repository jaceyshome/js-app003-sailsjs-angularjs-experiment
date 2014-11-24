var CommonHelper, Promise, YAML;

YAML = require('yamljs');

CommonHelper = require('../helpers/Common');

Promise = require("bluebird");

module.exports = (function() {
  var userModel;
  userModel = {};
  userModel.tableName = "users";
  userModel.migrate = "safe";
  userModel.attributes = YAML.load('assets/validations/user.yml');
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
        return next({
          err: ["Internal Server Error."]
        });
      });
    });
  };
  userModel.beforeDestroy = function(values, next) {
    return next();
  };
  return userModel;
})();
