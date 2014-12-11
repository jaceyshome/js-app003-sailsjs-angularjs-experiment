define [
  'app/states/project/new/new-module'
], ->
  module = angular.module 'app.states.project.new'
  module.controller 'ProjectNewCtrl', ($scope, $state, ProjectService) ->
    $scope.project =
      name: "test project"
      description: "test project description"
      "stages": [
        {
          "id": 1,
          "title": "stage 1",
          "tasks": [
            {
              "id": 10,
              "title": "task 1.1",
              "tasks": []
            },
            {
              "id": 100,
              "title": "task 1.2",
              "tasks": []
            }
          ]
        },
        {
          "id": 1000,
          "title": "stage 2",
          "tasks": [
            {
              "id": 10000,
              "title": "task 2.1",
              "tasks": []
            },
            {
              "id": 10001,
              "title": "task 2.2",
              "tasks": []
            }
          ]
        },
        {
          "id": 3,
          "title": "stage 3",
          "tasks": [
            {
              "id": 30,
              "title": "task 3.1",
              "tasks": []
            },
            {
              "id": 31,
              "title": "task 3.2",
              "tasks": []
            }
          ]
        }
      ]

    $scope.addStage = ()->
      id = $scope.project.stages.length+1
      $scope.project.stages.push({
        "id": id
        "title": "new stage"
        "tasks": []
      })

    $scope.remove = (scope)->
      scope.remove()

    $scope.toggle = (scope)->
      scope.toggle()

    $scope.newTask = (scope)->
      nodeData = scope.$modelValue
      nodeData.tasks.push({
        id: nodeData.id * 10 + nodeData.tasks.length,
        title: nodeData.title + '.' + (nodeData.tasks.length + 1),
        tasks: []
      })

    $scope.submit = ->
      console.log "project new ctrl", $scope.project
      ProjectService.createProject($scope.project)