var CommonHelper, Promise, YAML;

YAML = require('yamljs');

CommonHelper = require('../helpers/Common');

Promise = require("bluebird");

module.exports = (function() {
  var projectModel;
  projectModel = {};
  projectModel.tableName = "projects";
  projectModel.migrate = "safe";
  projectModel.attributes = YAML.load('assets/validations/project.yml');
  projectModel.beforeCreate = function(values, next) {
    return CommonHelper.generateShortLink(projectModel.attributes.shortLink.maxLength).then(function(result) {
      values.shortLink = result;
      return next();
    })["catch"](function() {
      return next({
        err: ["Internal Server Error."]
      });
    });
  };
  projectModel.beforeDestroy = function(values, next) {
    return next();
  };
  return projectModel;
})();
