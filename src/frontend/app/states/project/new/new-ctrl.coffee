define [
  'app/states/project/new/new-module'
], ->
  module = angular.module 'app.states.project.new'
  module.controller 'ProjectNewCtrl', ($scope, $state, ProjectService) ->
    $scope.project =
      name: ""
      description: ""
      stages : []

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