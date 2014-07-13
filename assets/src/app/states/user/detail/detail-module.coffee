define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.user.detail', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'common.user.detail.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "userdetail",
      templateUrl: "app/states/user/detail/detail"
      url: "/user/detail"
      controller: "UserDetailCtrl"