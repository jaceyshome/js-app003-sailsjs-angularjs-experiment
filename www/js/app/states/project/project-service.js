define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config, csrf) {
  var appModule;
  appModule = angular.module('app.states.project.service', []);
  return appModule.factory("ProjectService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket) {
    var handleErrorMsg, service, _project, _projects;
    _projects = null;
    _project = null;
    $sailsSocket.subscribe('project', function(data) {
      return console.log("project msg", data);
    });
    $sailsSocket.get('/project/subscribe').success(function() {
      return console.log("get project subscribe");
    });
    service = {};
    service.goToDefault = function() {
      return $state.go('/');
    };
    service.getProject = function() {
      return _project;
    };
    service.setProject = function(project) {
      return _project = project;
    };
    service.listProjects = function() {
      var deferred;
      deferred = $q.defer();
      if (_projects) {
        deferred.resolve(_projects);
      } else {
        $http.get("" + config.baseUrl + "/project/all").then(function(result) {
          _projects = result.data;
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          deferred.resolve(null);
          return handleErrorMsg(err);
        });
      }
      return deferred.promise;
    };
    service.createProject = function(project) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        project._csrf = data._csrf;
        return $http.post("" + config.baseUrl + "/project/create", project).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.getProjectDetail = function(project) {
      var deferred;
      deferred = $q.defer();
      if (angular.equals(project, _project)) {
        deferred.resolve(project);
      }
      $http.get("" + config.baseUrl + "/project/specifics/" + project.shortLink).then(function(result) {
        return deferred.resolve(result.data);
      })["catch"](function(err) {
        handleErrorMsg(err);
        return deferred.resolve(null);
      });
      return deferred.promise;
    };
    service.updateProject = function(project) {
      var deferred;
      deferred = $q.defer();
      return CSRF.get().then(function(data) {
        var editingProject;
        editingProject = {
          id: project.id,
          shortLink: project.shortLink,
          name: project.name,
          description: project.description,
          _csrf: data._csrf
        };
        $http.put("" + config.baseUrl + "/project/update", editingProject).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
        return deferred.promise;
      });
    };
    service.destroyProject = function(project) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        var deletingProject;
        deletingProject = {
          id: project.id,
          shortLink: project.shortLink,
          _csrf: data._csrf
        };
        return $http.post("" + config.baseUrl + "/project/destroy", deletingProject).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    handleErrorMsg = function(err) {
      return MessageService.handleServerError(err);
    };
    return service;
  });
});

//# sourceMappingURL=project-service.js.map
