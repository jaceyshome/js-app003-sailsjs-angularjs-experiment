define [
  'angular'
  'app/states/project/details/details-module'
], ->
  module = angular.module 'app.states.project.details'
  module.controller 'ProjectDetailsCtrl', ($scope, $state, ProjectData) ->
    $scope.project = ProjectData

    $scope.edit = ->
      $state.go "project.edit", {shortLink: ProjectData.shortLink}

