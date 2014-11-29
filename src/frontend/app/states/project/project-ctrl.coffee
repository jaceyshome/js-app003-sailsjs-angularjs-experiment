define [
  'app/states/project/project-module'
  'app/states/project/project-service'
  'app/states/project/list/list-ctrl'
  'app/states/project/edit/edit-ctrl'
  'app/states/project/new/new-ctrl'
  'app/states/project/details/details-ctrl'
], ->
  module = angular.module 'app.states.project'
  module.controller 'ProjectCtrl', ($scope, $state) ->
    $scope.tree2 = [{
      "id": 1,
      "title": "tree2 - item1",
      "nodes": [],
    }, {
      "id": 2,
      "title": "tree2 - item2",
      "nodes": [],
    }, {
      "id": 3,
      "title": "tree2 - item3",
      "nodes": [],
    }, {
      "id": 4,
      "title": "tree2 - item4",
      "nodes": [],
    }]

    $scope.remove = (scope)->
      console.log "toggle", scope
      scope.remove()

    $scope.toggle = (scope)->
      console.log "toggle", scope
      scope.toggle()

    $scope.newSubItem = (scope)->
      console.log "herer", scope
      nodeData = scope.$modelValue
      nodeData.nodes.push({
        id: nodeData.id * 10 + nodeData.nodes.length,
        title: nodeData.title + '.' + (nodeData.nodes.length + 1),
        nodes: []
      })
