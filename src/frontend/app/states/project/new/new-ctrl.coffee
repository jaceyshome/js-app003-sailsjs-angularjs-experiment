define [
  'app/states/project/new/new-module'
], ->
  module = angular.module 'app.states.project.new'
  module.controller 'ProjectNewCtrl', ($scope, $state, ProjectService) ->
    console.log "project new ctrl"
    $scope.sumbit = ->
      ProjectService.createProject($scope.project)

