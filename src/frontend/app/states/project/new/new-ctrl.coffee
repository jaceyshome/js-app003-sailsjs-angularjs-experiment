define [
  'app/states/project/new/new-module'
], ->
  module = angular.module 'app.states.project.new'
  module.controller 'ProjectNewCtrl', ($scope, $state, ProjectService) ->
    $scope.project =
      name: ""
      description: ""
      stages : [{
        "id": 1,
        "title": "stage item 1",
        "nodes": []
      }]

    $scope.remove = (scope)->
      scope.remove()

    $scope.toggle = (scope)->
      scope.toggle()

    $scope.newNode = (scope)->
      nodeData = scope.$modelValue
      nodeData.nodes.push({
        id: nodeData.id * 10 + nodeData.nodes.length,
        title: nodeData.title + '.' + (nodeData.nodes.length + 1),
        nodes: []
      })

    $scope.submit = ->
      console.log "project new ctrl", $scope.project
      ProjectService.createProject($scope.project)