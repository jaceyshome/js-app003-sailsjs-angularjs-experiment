define(['app/states/project/list/list-module', 'app/states/project/project-service'], function() {
  var module;
  module = angular.module('app.states.project.list');
  return module.controller('ProjectListCtrl', function($scope, $state, Projects, ProjectService) {
    $scope.projects = Projects;
    $scope.show = function(project) {
      return $state.go("project.details", {
        shortLink: project.shortLink
      });
    };
    $scope.destroy = function(project) {
      return ProjectService.destroyProject(project).then(function(result) {
        if (result) {
          return $scope.projects.splice($scope.projects.indexOf(project), 1);
        } else {
          return console.log("servers error");
        }
      });
    };
    return $scope.edit = function(project) {
      console.log("edit project", project);
      return $state.go("project.edit", {
        shortLink: project.shortLink
      });
    };
  });
});

//# sourceMappingURL=list-ctrl.js.map
