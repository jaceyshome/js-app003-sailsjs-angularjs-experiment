define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.home', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "home",
      templateUrl: "app/states/home/home"
      url: "/home"
      controller:"HomeCtrl"