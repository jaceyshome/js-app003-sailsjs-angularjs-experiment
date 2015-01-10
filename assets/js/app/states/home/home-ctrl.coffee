define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, Projects, ProjectService, $state) ->
    $scope.projects = Projects
    $scope.panelsListSettings = null

    init = ()->
      initPanelListSettings()

    initPanelListSettings = ->
      $scope.panelsListSettings =
        data: Projects

    init()