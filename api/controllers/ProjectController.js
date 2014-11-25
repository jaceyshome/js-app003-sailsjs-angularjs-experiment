var CommonHelper, Promise;

CommonHelper = require('../helpers/Common');

Promise = require("bluebird");

module.exports = (function() {
  var ctrl;
  ctrl = {};
  ctrl["new"] = function(req, res, next) {
    return res.view('app');
  };
  ctrl.list = function(req, res, next) {
    return res.view('app');
  };
  ctrl.details = function(req, res, next) {
    return res.view('app');
  };
  ctrl.edit = function(req, res, next) {
    return res.view('app');
  };
  ctrl.create = function(req, res, next) {
    return Project.create(req.params.all(), function(err, project) {
      if (err) {
        return next(err);
      }
      return project.save(function(err, project) {
        var projectJson;
        if (err) {
          return next(err);
        }
        Project.publishCreate({
          id: project.id,
          name: project.name
        }, req.socket);
        projectJson = {
          id: project.id,
          name: project.name,
          description: project.description,
          shortLink: project.shortLink
        };
        return res.json(projectJson);
      });
    });
  };
  ctrl.specifics = function(req, res, next) {
    return Project.findByShortLink(req.param('shortLink')).exec(function(err, project) {
      var projectJson;
      if (err || !project) {
        return next(err);
      }
      projectJson = {
        id: project[0].id,
        name: project[0].name,
        description: project[0].description,
        shortLink: project[0].shortLink
      };
      return res.json(projectJson);
    });
  };
  ctrl.all = function(req, res, next) {
    return Project.query("SELECT id, name, description, shortLink FROM projects", function(err, projects) {
      if (err || !projects) {
        return next(err);
      }
      return res.json(projects);
    });
  };
  ctrl.update = function(req, res, next) {
    var data;
    data = {
      name: req.param("name"),
      description: req.param("description")
    };
    return Project.update(req.param("id"), data, function(err) {
      if (err) {
        return next(err);
      }
      Project.publishUpdate(req.param("id"), {
        id: req.param("id"),
        name: req.param("name")
      }, req.socket);
      return res.send(200);
    });
  };
  ctrl.destroy = function(req, res, next) {
    return Project.destroy(req.param("id"), function(err) {
      if (err) {
        return next(err);
      }
      Project.publishDestroy(req.param("id"), req.socket);
      return res.send(200);
    });
  };
  ctrl.subscribe = function(req, res, next) {
    return Project.find(function(err, projects) {
      if (err) {
        return next(err);
      }
      Project.watch(req.socket);
      Project.subscribe(req.socket, projects);
      return res.send(200);
    });
  };
  ctrl._config = {};
  return ctrl;
})();
