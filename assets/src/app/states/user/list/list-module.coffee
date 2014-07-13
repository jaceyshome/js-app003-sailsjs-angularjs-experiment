define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.user.list', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'app.states.user.list.resource'

  ]

  module.config ($stateProvider)->
    $stateProvider.state "user.list",
      templateUrl: "app/states/list/list"
      url: "/list"
      controller: "UserListCtrl"