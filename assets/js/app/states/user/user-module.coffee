define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.user', [
    'ui.router'
    'templates'
    'app.states.user.service'
    'app.states.user.list'
    'app.states.user.details'
    'app.states.user.edit'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user",
      templateUrl: "app/states/user/user"
      url: "/user"
      controller: "UserCtrl"
