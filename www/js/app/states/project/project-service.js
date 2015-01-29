define(['angular', 'angular_resource', 'app/config', 'lodash'], function(angular, angular_resource, config, _) {
  var appModule;
  appModule = angular.module('app.states.project.service', []);
  return appModule.factory("ProjectService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket) {
    var compareByPos, formatProject, getTaskStatus, handleCreatedProjectAfter, handleCurrentTask, handleErrorMsg, handleFetchProjectAfter, handleNewTask, handleOldTask, handleUpdatedProjectAfter, service, sortProjectStages, sortStageTasks, _projects;
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
    service.fetchProjects = function() {
      var deferred;
      deferred = $q.defer();
      if (_projects) {
        deferred.resolve(_projects);
      } else {
        $http.get("" + config.baseUrl + "/project/all").then(function(result) {
          _projects = result.data;
          return deferred.resolve(_projects);
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
    service.fetchProject = function(project) {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/project/specify/" + project.id + "/s/" + project.shortLink).then(function(result) {
        var _project;
        _project = handleFetchProjectAfter(result.data);
        return deferred.resolve(_project);
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
        return $http["delete"]("" + config.baseUrl + "/project/destroy/" + project.id + "/s/" + project.shortLink + "/?_csrf=" + (encodeURIComponent(data._csrf))).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.handleUpdatedStageAfter = function(stage) {
      var _project, _stage;
      _project = _.find(_projects, {
        'id': stage.idProject
      });
      if (!(_project.stages && _project.stages.length > 0)) {
        return sortProjectStages(_project);
      }
      _stage = _.find(_project.stages, {
        'id': stage.id
      });
      if (_stage.id === stage.id && _stage.idProject === stage.idProject) {
        _.merge(_stage, stage);
        return sortProjectStages(_project);
      }
    };
    service.handleCreatedStageAfter = function(stage) {
      var _project, _stage;
      _project = _.find(_projects, {
        'id': stage.idProject
      });
      if (!_project.stages) {
        _project.stages = [];
      }
      _stage = _.find(_project.stages, {
        'id': stage.id
      });
      if (!(_stage && _stage.id === stage.id)) {
        _project.stages.push(stage);
      }
      return sortProjectStages(_project);
    };
    service.handleDestroyedStageAfter = function(stageId) {
      var stage, task, _i, _j, _len, _len1, _project, _ref, _results;
      if (!stageId) {
        return;
      }
      _results = [];
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        _project = _projects[_i];
        if (_project.tasks) {
          _ref = _project.tasks;
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            task = _ref[_j];
            if ((task != null ? task.idStage : void 0) === stageId) {
              _project.tasks.splice(_project.tasks.indexOf(task), 1);
            }
          }
        }
        stage = _.find(_project.stages, {
          'id': stageId
        });
        if ((stage != null ? stage.id : void 0) === stageId) {
          _results.push(_project.stages.splice(_project.stages.indexOf(stage), 1));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    service.handleCreatedTaskAfter = function(task) {
      var _project, _stage, _task;
      if (!task.idProject) {
        return;
      }
      if (!task.idStage) {
        return;
      }
      _project = _.find(_projects, {
        'id': task.idProject
      });
      _stage = _.find(_project.stages, {
        'id': task.idStage
      });
      if (!_stage.tasks) {
        _stage.tasks = [];
      }
      _task = _.find(_stage.tasks, {
        'id': task.id
      });
      if (!_task) {
        _stage.tasks.push(task);
      }
      return sortStageTasks(_stage);
    };
    service.handleUpdatedTaskAfter = function(task) {
      var result, _project, _stage;
      result = getTaskStatus(task);
      if (result.oldTask) {
        handleOldTask(result.oldTask);
      }
      if (result.newTask) {
        handleNewTask(result.newTask);
      }
      if (result.currentTask) {
        handleCurrentTask(result.currentTask, task);
      }
      _project = _.find(_projects, {
        'id': task.idProject
      });
      _stage = _.find(_project.stages, {
        'id': task.idStage
      });
      sortStageTasks(_stage);
    };
    service.handleDestroyedTaskAfter = function(taskId) {
      var proj, stage, task, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2;
      if (!taskId) {
        return;
      }
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (!proj.tasks) {
          continue;
        }
        _ref = proj.tasks;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          task = _ref[_j];
          if ((task != null ? task.id : void 0) === taskId) {
            proj.tasks.splice(proj.tasks.indexOf(task), 1);
          }
        }
        if (!proj.stages) {
          continue;
        }
        _ref1 = proj.stages;
        for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
          stage = _ref1[_k];
          if (!stage.tasks) {
            continue;
          }
          _ref2 = stage.tasks;
          for (_l = 0, _len3 = _ref2.length; _l < _len3; _l++) {
            task = _ref2[_l];
            if ((task != null ? task.id : void 0) === taskId) {
              stage.tasks.splice(stage.tasks.indexOf(task), 1);
            }
          }
        }
      }
    };
    getTaskStatus = function(task) {
      var result, _i, _len, _project, _task;
      result = {
        currentTask: null,
        oldTask: null,
        newTask: null
      };
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        _project = _projects[_i];
        _task = _.find(_project.tasks, {
          id: task.id
        });
        if (_task) {
          console.log("_task", _task);
          if (!angular.equals(_task.idProject, task.idProject) || !angular.equals(_task.idStage, task.idStage)) {
            result.oldTask = _task;
            result.newTask = task;
            console.log("result old and new", result);
          } else {
            result.currentTask = _task;
            console.log("current task", result);
          }
        }
      }
      return result;
    };
    handleNewTask = function(newTask) {
      var _project, _stage, _task;
      _project = _.find(_projects, {
        'id': newTask.idProject
      });
      if (!_project) {
        return;
      }
      _stage = _.find(_project.stages, {
        'id': newTask.idStage
      });
      if (!_stage) {
        return;
      }
      if (!_stage.tasks) {
        _stage.tasks = [];
      }
      _task = _.find(_stage.tasks, {
        'id': newTask.id
      });
      if (!_task) {
        _stage.tasks.push(newTask);
      }
    };
    handleOldTask = function(oldTask) {
      var _project, _stage;
      _project = _.find(_projects, {
        'id': oldTask.idProject
      });
      if (!_project) {
        return;
      }
      _stage = _.find(_project.stages, {
        'id': oldTask.idStage
      });
      if (!_stage) {
        return;
      }
      _stage.tasks.splice(_stage.tasks.indexOf(oldTask), 1);
    };
    handleCurrentTask = function(currentTask, task) {
      _.merge(currentTask, task);
    };
    handleUpdatedProjectAfter = function(project) {
      var proj, _i, _len;
      if (!_projects) {
        return;
      }
      for (_i = 0, _len = _projects.length; _i < _len; _i++) {
        proj = _projects[_i];
        if (proj.id === project.id && proj.shortLink === project.shortLink) {
          _.merge(proj, project);
          return;
        }
      }
    };
    handleCreatedProjectAfter = function(project) {
      if (!_projects) {
        return;
      }
      if (project.id === _projects[project.id].id && project.shortLink === _projects[project.id].shortLink) {
        return;
      }
      _projects[project.id] = project;
    };
    handleFetchProjectAfter = function(project) {
      var _project;
      if (!_projects) {
        return;
      }
      if (_projects) {
        _project = _.find(_projects, {
          'id': project.id
        });
        return _.merge(_project, formatProject(project));
      }
    };
    formatProject = function(project) {
      var stages, _project;
      if (!(project != null ? project.stages : void 0)) {
        return;
      }
      if (!(project != null ? project.tasks : void 0)) {
        return;
      }
      if (project.stages) {
        stages = _.map(project.stages, function(_stage) {
          if (project.tasks) {
            _stage.tasks = _.where(project.tasks, {
              'idStage': _stage.id
            });
            sortStageTasks(_stage);
            return _stage;
          }
        });
      }
      _project = {
        stages: stages
      };
      sortProjectStages(_project);
      return _.merge(project, _project);
    };
    sortProjectStages = function(project) {
      if (!project.stages) {
        return;
      }
      project.stages.sort(compareByPos);
      return project;
    };
    sortStageTasks = function(stage) {
      if (!stage.tasks) {
        return;
      }
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
