define(['app/states/project/new/new-module'], function() {
  var module;
  module = angular.module('app.states.project.new');
  return module.controller('ProjectNewCtrl', function($scope, $state, ProjectService) {
    $scope.project = {
      name: "test project",
      description: "test project description",
      "stages": [
        {
          "id": 1,
          "title": "stage 1",
          "tasks": [
            {
              "id": 10,
              "title": "task 1.1",
              "tasks": []
            }, {
              "id": 100,
              "title": "task 1.2",
              "tasks": []
            }
          ]
        }, {
          "id": 1000,
          "title": "stage 2",
          "tasks": [
            {
              "id": 10000,
              "title": "task 2.1",
              "tasks": []
            }, {
              "id": 10001,
              "title": "task 2.2",
              "tasks": []
            }
          ]
        }, {
          "id": 3,
          "title": "stage 3",
          "tasks": [
            {
              "id": 30,
              "title": "task 3.1",
              "tasks": []
            }, {
              "id": 31,
              "title": "task 3.2",
              "tasks": []
            }
          ]
        }
      ]
    };
    $scope.addStage = function() {
      var id;
      id = $scope.project.stages.length + 1;
      return $scope.project.stages.push({
        "id": id,
        "title": "new stage",
        "tasks": []
      });
    };
    $scope.remove = function(scope) {
      return scope.remove();
    };
    $scope.toggle = function(scope) {
      return scope.toggle();
    };
    $scope.newTask = function(scope) {
      var nodeData;
      nodeData = scope.$modelValue;
      return nodeData.tasks.push({
        id: nodeData.id * 10 + nodeData.tasks.length,
        title: nodeData.title + '.' + (nodeData.tasks.length + 1),
        tasks: []
      });
    };
    return $scope.submit = function() {
      console.log("project new ctrl", $scope.project);
      return ProjectService.createProject($scope.project);
    };
  });
});

//# sourceMappingURL=new-ctrl.js.map
