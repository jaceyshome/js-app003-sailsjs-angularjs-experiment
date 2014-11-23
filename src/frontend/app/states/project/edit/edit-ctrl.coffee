define [
  'app/states/project/edit/edit-module'
], ->
  module = angular.module 'app.states.project.edit'
  module.controller 'ProjectEditCtrl', ($scope, $state, ProjectData, ProjectService) ->
    $scope.project = angular.copy ProjectData
    $scope.sumbit = ->
      ProjectService.updateProject($scope.project)

