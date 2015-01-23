define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.project.list', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project.list", {
      parent: 'project',
      url: "/list",
      views: {
        'projectChildView@project': {
          templateUrl: "app/states/project/list/list",
          controller: "ProjectListCtrl"
        }
      },
      resolve: {
        Projects: function($q, ProjectService) {
          var deferred;
          deferred = $q.defer();
          ProjectService.fetchProjects().then(function(result) {
            return deferred.resolve(result);
          })["catch"](function() {
            ProjectService.goToDefault();
            return deferred.resolve(null);
          });
          return deferred.promise;
        }
      }
    });
  });
});

//# sourceMappingURL=list-module.js.map
