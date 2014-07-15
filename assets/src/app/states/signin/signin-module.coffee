define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.signin', [
    'ui.router'
    'templates'
    'app.states.signin.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "signin",
      templateUrl: "app/states/signin/signin"
      url: "/signin"
      controller: "SigninCtrl"