define(['angular'], function() {
  var module;
  module = angular.module('app.states.project.details.projectstages', []);
  return module.directive('projectStages', function(StageService, ProjectService, TaskService, Constants, AppService) {
    return {
      restrict: "A",
      scope: {
        settings: "="
      },
      templateUrl: "app/states/project/details/projectstages/projectstages",
      link: function($scope, $element, $attrs) {
        var init, reset, resetEditingStage, resetNewTask;
        $scope.editingStage = null;
        $scope.newTask = {
          name: ""
        };
        $scope.options = {
          accept: function(sourceNode, destNodes, destIndex) {
            return destNodes.$element.attr("type") === 'stage';
          },
          dropped: function(event) {
            var dest, source, stage;
            source = event.source;
            dest = event.dest;
            if (source.index !== dest.index) {
              stage = source.nodeScope.$modelValue;
              AppService.updatePos(stage, dest.nodesScope.$modelValue);
              StageService.updateStage(stage);
            }
          },
          beforeDrop: function(event) {
            if (event.dest.nodesScope.$element.attr("type") !== 'stage') {
              event.source.nodeScope.$$apply = false;
            }
          }
        };
        init = function() {
          if (!$scope.settings) {
            $scope.settings = {};
          }
          return $scope.settings.editingKey = null;
        };
        reset = function() {
          $scope.settings.editingKey = null;
          resetEditingStage();
          return resetNewTask();
        };
        resetEditingStage = function() {
          return $scope.editingStage = null;
        };
        resetNewTask = function() {
          return $scope.newTask = {
            name: ""
          };
        };
        $scope.editStage = function(stage) {
          reset();
          return $scope.editingStage = angular.copy(stage);
        };
        $scope.removeStage = function(stage) {
          return StageService.destroyStage(stage);
        };
        $scope.saveEditingStage = function(stage) {
          var _ref;
          if (!$scope.editingStage.name) {
            return;
          }
          if (((_ref = $scope.editingStage) != null ? _ref.id : void 0) !== (stage != null ? stage.id : void 0)) {
            return;
          }
          return StageService.updateStage($scope.editingStage).then(resetEditingStage);
        };
        $scope.resetEditingStage = resetEditingStage;
        $scope.showNewTaskFieldToStage = function(stage) {
          reset();
          return $scope.settings.editingKey = "" + stage.id + "_task";
        };
        $scope.addTaskToStage = function(stage) {
          var data, _ref;
          if (!(((_ref = $scope.newTask.name) != null ? _ref.length : void 0) > 0)) {
            return;
          }
          data = angular.copy($scope.newTask);
          data.idStage = stage.id;
          data.idProject = stage.idProject;
          return TaskService.createTask(data).then(resetNewTask);
        };
        return init();
      }
    };
  });
});

//# sourceMappingURL=projectstages.js.map
