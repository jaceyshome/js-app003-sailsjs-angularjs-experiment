define [
  'app/states/project/edit/edit-module'
], ->
  module = angular.module 'app.states.user.edit'
  module.controller 'ProjectEditCtrl', ($scope, $state, ProjectData, ProjectService, SailsSocket) ->
    $scope.project = angular.copy ProjectData
    $scope.sumbit = ->
      ProjectService.updateProject($scope.project)

