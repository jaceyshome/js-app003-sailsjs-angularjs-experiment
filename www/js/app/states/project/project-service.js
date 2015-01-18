define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var appModule;
  appModule = angular.module('app.states.project.service', []);
  return appModule.factory("ProjectService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket) {
    var compareByPos, formatProjectStagesTasks, handleCreatedProjectAfter, handleErrorMsg, handleGetProjectDetailAfter, handleSortProjectStages, handleSortStageTasks, handleUpdatedProjectAfter, service, _projects;
    _projects = null;
    $sailsSocket.subscribe('project', function(res) {
      console.log("project msg", res);
      if (res.verb === 'created') {
        handleCreatedProjectAfter(res.data);
      }
      if (res.verb === 'updated') {
        return handleUpdatedProjectAfter(res.data);
      }
    });
    $sailsSocket.get('/project/subscribe').success(function() {
      return console.log("get project subscribe");
    });
    service = {};
    service.goToDefault = function() {
      return $state.go('/');
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
          _projects.push(result.data);
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.specifyProject = function(project) {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/project/specify/" + project.id + "/s/" + project.shortLink).then(function(result) {
        return deferred.resolve(handleGetProjectDetailAfter(result.data));
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
        project._csrf = data._csrf;
        $http.put("" + config.baseUrl + "/project/update", project).then(function(result) {
          handleUpdatedProjectAfter(result.data);
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
    service.handleUpdatedStageAfter = function(stage) {
      var proj, _i, _j, _len, _len1, _ref, _stage;
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === stage.idProject) {
          if (!(proj.stages && proj.stages.length > 0)) {
            return handleSortProjectStages(proj);
          }
          _ref = proj.stages;
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            _stage = _ref[_j];
            if (_stage.id === stage.id && _stage.idProject === stage.idProject) {
              angular.extend(_stage, stage);
              return handleSortProjectStages(proj);
            }
          }
        }
      }
    };
    service.handleCreatedStageAfter = function(stage) {
      var proj, _i, _j, _len, _len1, _ref, _sg;
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id.toString() === stage.idProject.toString()) {
          if (!proj.stages) {
            proj.stages = [];
          }
          _ref = proj.stages;
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            _sg = _ref[_j];
            if (_sg.id === stage.id && _sg.idProject === stage.idProject) {
              return handleSortProjectStages(proj);
            }
          }
          proj.stages.push(stage);
          return handleSortProjectStages(proj);
        }
      }
    };
    service.handleDestroyedStageAfter = function(stageId) {
      var proj, stage, task, _i, _j, _len, _len1, _ref, _results;
      if (!stageId) {
        return;
      }
      _results = [];
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        _ref = proj.tasks;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          task = _ref[_j];
          if ((task != null ? task.idStage : void 0) === stageId) {
            proj.tasks.splice(proj.tasks.indexOf(task), 1);
          }
        }
        _results.push((function() {
          var _k, _len2, _ref1, _results1;
          _ref1 = proj.stages;
          _results1 = [];
          for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
            stage = _ref1[_k];
            if ((stage != null ? stage.id : void 0) === stageId) {
              _results1.push(proj.stages.splice(proj.stages.indexOf(stage), 1));
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        })());
      }
      return _results;
    };
    service.handleCreatedTaskAfter = function(task) {
      var proj, stage, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _task;
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id.toString() === task.idProject.toString()) {
          if (!proj.stages) {
            return;
          }
          _ref = proj.stages;
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            stage = _ref[_j];
            if (stage.id === task.idStage && proj.id === stage.idProject) {
              if (!stage.tasks) {
                stage.tasks = [];
              }
              _ref1 = stage.tasks;
              for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
                _task = _ref1[_k];
                if (_task.id === task.id && _task.idStage === task.idStage && _task.idProject === task.idProject) {
                  return handleSortStageTasks(proj);
                }
              }
              stage.tasks.push(task);
              return handleSortStageTasks(stage);
            }
          }
        }
      }
    };
    handleUpdatedProjectAfter = function(project) {
      var proj, _i, _len;
      if (!_projects) {
        return;
      }
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === project.id && proj.shortLink === project.shortLink) {
          angular.extend(proj, project);
          return;
        }
      }
    };
    handleCreatedProjectAfter = function(project) {
      var proj, _i, _len;
      if (!_projects) {
        return;
      }
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === project.id && proj.shortLink === project.shortLink) {
          return;
        }
      }
      return _projects.push(project);
    };
    handleGetProjectDetailAfter = function(project) {
      var proj, _i, _len;
      if (!_projects) {
        return;
      }
      formatProjectStagesTasks(project);
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === project.id && proj.shortLink === project.shortLink) {
          angular.extend(proj, project);
          return proj;
        }
      }
    };
    formatProjectStagesTasks = function(project) {
      var stage, task, _i, _len, _ref, _results;
      if (!(project != null ? project.stages : void 0)) {
        return;
      }
      if (!(project != null ? project.tasks : void 0)) {
        return;
      }
      _ref = project.stages;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        stage = _ref[_i];
        stage.tasks = [];
        _results.push((function() {
          var _j, _len1, _ref1, _results1;
          _ref1 = project.tasks;
          _results1 = [];
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            task = _ref1[_j];
            if (task.idStage.toString() === stage.id.toString()) {
              _results1.push(stage.tasks.push(task));
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        })());
      }
      return _results;
    };
    handleSortProjectStages = function(project) {
      return project.stages.sort(compareByPos);
    };
    handleSortStageTasks = function(stage) {
      return stage.tasks.sort(compareByPos);
    };
    compareByPos = function(a, b) {
      if (a.pos < b.pos) {
        return -1;
      }
      if (a.pos > b.pos) {
        return 1;
      }
      return 0;
    };
    handleErrorMsg = function(err) {
      return MessageService.handleServerError(err);
    };
    return service;
  });
});

//# sourceMappingURL=project-service.js.map
