define(['angular', 'app/states/project/details/details-module'], function() {
  var module;
  module = angular.module('app.states.project.details');
  return module.controller('ProjectDetailsCtrl', function($scope, $state, Project, ProjectService, StageService) {
    var init, reset, setProjectStagesSettings;
    $scope.project = Project;
    $scope.editingProject = angular.copy(Project);
    $scope.projectStagesSettings = null;
    $scope.newStage = {
      idProject: Project.id,
      name: ""
    };
    $scope.settings = {
      editKey: null
    };
    init = function() {
      return setProjectStagesSettings();
    };
    setProjectStagesSettings = function() {
      return $scope.projectStagesSettings = {
        data: Project
      };
    };
    reset = function() {
      return $scope.settings = {
        editKey: null
      };
    };
    $scope.save = function() {
      return ProjectService.updateProject($scope.editingProject).then(reset);
    };
    $scope.cancelEditing = function(key) {
      $scope.editingProject[key] = $scope.project[key];
      return reset();
    };
    $scope.addStage = function() {
      if (!$scope.project.stages) {
        $scope.project.stages = [];
      }
      return StageService.createStage($scope.newStage).then(function() {
        reset();
        return $scope.newStage = {
          idProject: Project.id,
          name: ""
        };
      });
    };
    return init();
  });
});

//# sourceMappingURL=details-ctrl.js.map
