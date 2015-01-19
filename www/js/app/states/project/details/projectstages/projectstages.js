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
        var init, reset, resetEditingStage, resetEditingTask;
        $scope.editingStage = null;
        $scope.editingTask = {
          name: ""
        };
        $scope.options = {
          accept: function(sourceNode, destNodes, destIndex) {
            var data, destType;
            data = sourceNode.$modelValue;
            destType = destNodes.$element.attr("type");
            return data.type === destType;
          },
          dropped: function(event) {
            var dest, source, stage;
            source = event.source;
            dest = event.dest;
            console.log("source.nodeScope", source.nodeScope);
            console.log("dest", dest);
            console.log("dest node scope parent", dest.nodesScope.isParent(source.nodeScope));
            console.log("dest node attr", dest.nodesScope.$element.attr("type"));
            if (source.index !== dest.index) {
              return stage = source.nodeScope.$modelValue;
            }
          },
          beforeDrop: function(event) {}
        };
        init = function() {
          return void 0;
        };
        reset = function() {
          resetEditingStage();
          return resetEditingTask();
        };
        resetEditingStage = function() {
          return $scope.editingStage = null;
        };
        resetEditingTask = function() {
          return $scope.editingTask = {
            name: ""
          };
        };
        $scope.editStage = function(stage) {
          return $scope.editingStage = angular.copy(stage);
        };
        $scope.removeStage = function(stage) {
          return StageService.destroyStage(stage);
        };
        $scope.saveEditingStage = function(stage) {
          var _ref;
          if (((_ref = $scope.editingStage) != null ? _ref.id : void 0) !== (stage != null ? stage.id : void 0)) {
            return;
          }
          return StageService.updateStage($scope.editingStage).then(resetEditingStage);
        };
        $scope.resetEditingStage = resetEditingStage;
        $scope.showEditingTaskToStage = function(stage) {
          if (typeof $scope.settings.resetParent === 'function') {
            $scope.settings.resetParent();
          }
          reset();
          return $scope.settings.editKey = 'newTask_' + stage.id;
        };
        $scope.addTaskToStage = function(stage) {
          var data, _ref;
          if (!(((_ref = $scope.editingTask.name) != null ? _ref.length : void 0) > 0)) {
            return;
          }
          data = angular.copy($scope.editingTask);
          data.idStage = stage.id;
          data.idProject = stage.idProject;
          return TaskService.createTask(data).then(resetEditingTask);
        };
        return init();
      }
    };
  });
});

//# sourceMappingURL=projectstages.js.map
