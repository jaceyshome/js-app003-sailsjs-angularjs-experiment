define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var appModule;
  appModule = angular.module('app.states.task.service', []);
  return appModule.factory("TaskService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket, ProjectService, StageService) {
    var handleCreatedTaskAfter, handleDestroyedTaskAfter, handleErrorMsg, handleGetTaskDetailAfter, handleUpdatedTaskAfter, service;
    $sailsSocket.subscribe('task', function(res) {
      console.log("task msg", res);
      if (res.verb === 'created') {
        handleCreatedTaskAfter(res.data);
      }
      if (res.verb === 'updated') {
        handleUpdatedTaskAfter(res.data);
      }
      if (res.verb === 'destroyed') {
        return handleDestroyedTaskAfter(res.id);
      }
    });
    $sailsSocket.get('/task/subscribe').success(function() {
      return console.log("get task subscribe");
    });
    service = {};
    service.goToDefault = function() {
      return $state.go('/');
    };
    service.listStages = function() {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/task/all").then(function(result) {
        return deferred.resolve(result.data);
      })["catch"](function(err) {
        deferred.resolve(null);
        return handleErrorMsg(err);
      });
      return deferred.promise;
    };
    service.createTask = function(task) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        task._csrf = data._csrf;
        return $http.post("" + config.baseUrl + "/task/create", task).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.specifyTask = function(task) {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/task/specify/" + task.id + "/sg/" + task.idStage + "/p/" + task.idProject).then(function(result) {
        return deferred.resolve(handleGetTaskDetailAfter(result.data));
      })["catch"](function(err) {
        handleErrorMsg(err);
        return deferred.resolve(null);
      });
      return deferred.promise;
    };
    service.updateTask = function(task) {
      var deferred;
      deferred = $q.defer();
      return CSRF.get().then(function(data) {
        task._csrf = data._csrf;
        $http.put("" + config.baseUrl + "/task/update", task).then(function(result) {
          handleUpdatedTaskAfter(result.data);
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
        return deferred.promise;
      });
    };
    service.destroyTask = function(task) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        task._csrf = data._csrf;
        return $http.post("" + config.baseUrl + "/task/destroy", task).then(function(result) {
          handleDestroyedTaskAfter(task.id);
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    handleCreatedTaskAfter = function(task) {
      return ProjectService.handleCreatedTaskAfter(task);
    };
    handleUpdatedTaskAfter = function(task) {};
    handleDestroyedTaskAfter = function(taskId) {};
    handleGetTaskDetailAfter = function(project) {};
    handleErrorMsg = function(err) {
      return MessageService.handleServerError(err);
    };
    return service;
  });
});

//# sourceMappingURL=task-service.js.map
