define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var appModule;
  appModule = angular.module('app.states.stage.service', []);
  return appModule.factory("StageService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket, ProjectService) {
    var handleCreatedStageAfter, handleDestroyedStageAfter, handleErrorMsg, handleGetStageDetailAfter, handleUpdatedStageAfter, service;
    $sailsSocket.subscribe('stage', function(res) {
      console.log("stage msg", res);
      if (res.verb === 'created') {
        handleCreatedStageAfter(res.data);
      }
      if (res.verb === 'updated') {
        handleUpdatedStageAfter(res.data);
      }
      if (res.verb === 'destroyed') {
        return handleDestroyedStageAfter(res.id);
      }
    });
    $sailsSocket.get('/stage/subscribe').success(function() {
      return console.log("get stage subscribe");
    });
    service = {};
    service.goToDefault = function() {
      return $state.go('/');
    };
    service.listStages = function() {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/stage/all").then(function(result) {
        return deferred.resolve(result.data);
      })["catch"](function(err) {
        deferred.resolve(null);
        return handleErrorMsg(err);
      });
      return deferred.promise;
    };
    service.createStage = function(stage) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        stage._csrf = data._csrf;
        return $http.post("" + config.baseUrl + "/stage/create", stage).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.specifyStage = function(stage) {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/stage/specify/" + stage.id + "/s/" + stage.shortLink).then(function(result) {
        return deferred.resolve(handleGetStageDetailAfter(result.data));
      })["catch"](function(err) {
        handleErrorMsg(err);
        return deferred.resolve(null);
      });
      return deferred.promise;
    };
    service.updateStage = function(stage) {
      var deferred;
      deferred = $q.defer();
      return CSRF.get().then(function(data) {
        stage._csrf = data._csrf;
        $http.put("" + config.baseUrl + "/stage/update", stage).then(function(result) {
          handleUpdatedStageAfter(result.data);
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
        return deferred.promise;
      });
    };
    service.destroyStage = function(stage) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        stage._csrf = data._csrf;
        return $http.post("" + config.baseUrl + "/stage/destroy", stage).then(function(result) {
          handleDestroyedStageAfter(stage.id);
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    handleUpdatedStageAfter = function(stage) {
      return ProjectService.handleUpdatedStageAfter(stage);
    };
    handleCreatedStageAfter = function(stage) {
      return ProjectService.handleCreatedStageAfter(stage);
    };
    handleDestroyedStageAfter = function(stageId) {
      return ProjectService.handleDestroyedStageAfter(stageId);
    };
    handleGetStageDetailAfter = function(project) {
      var proj, _i, _len;
      if (!_projects) {
        return;
      }
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === project.id && proj.shortLink === project.shortLink) {
          angular.extend(proj, project);
          return proj;
        }
      }
    };
    handleErrorMsg = function(err) {
      return MessageService.handleServerError(err);
    };
    return service;
  });
});

//# sourceMappingURL=stage-service.js.map
