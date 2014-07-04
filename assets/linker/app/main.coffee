define [
  'angular'
  'angular_ui_router'
  'app/states/intro/main'
  'app/states/text/main'
  'common/navigation/main'
  'templates'
  ], ->
  module = angular.module 'app', [
    'app.states.intro'
    'app.states.text'
    'common.navigation'
    'templates'
    'ui.router'
  ]
  module.config ($locationProvider, $stateProvider)->
    $stateProvider.state "intro",
      templateUrl: "app/states/intro/main"
      controller:"IntroCtrl"
    $stateProvider.state "text",
      templateUrl: "app/states/text/main"
      controller:"TextCtrl"

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = false


