define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.home', [
    'ui.router'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "home",
      templateUrl: "app/states/home/home"
      url: "/"
      controller:"HomeCtrl"