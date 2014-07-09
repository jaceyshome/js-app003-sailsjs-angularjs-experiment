define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.user', [
    'app.states.user.service'
    'ui.router'
    'templates'
    'common.csrf.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user",
      templateUrl: "app/states/user/user"
      url: "/user"
      controller: "UserCtrl"