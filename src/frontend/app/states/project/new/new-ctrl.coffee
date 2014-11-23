define [
  'app/states/project/new/new-module'
], ->
  module = angular.module 'app.states.project.new'
  module.controller 'ProjectNewCtrl', ($scope, $state, ProjectService) ->
    $scope.submit = ->
      console.log "project new ctrl", $scope.project
      ProjectService.createProject($scope.project)

