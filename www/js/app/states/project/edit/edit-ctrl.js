define(['app/states/project/edit/edit-module'], function() {
  var module;
  module = angular.module('app.states.project.edit');
  return module.controller('ProjectEditCtrl', function($scope, $state, ProjectData, ProjectService) {
    $scope.project = angular.copy(ProjectData);
    return $scope.submit = function() {
      return ProjectService.updateProject($scope.project);
    };
  });
});

//# sourceMappingURL=edit-ctrl.js.map
