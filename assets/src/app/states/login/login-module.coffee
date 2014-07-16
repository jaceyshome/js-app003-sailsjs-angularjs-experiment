define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.login', [
    'ui.router'
    'templates'
    'app.states.login.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "login",
      templateUrl: "app/states/login/login"
      url: "/login"
      controller: "LoginCtrl"