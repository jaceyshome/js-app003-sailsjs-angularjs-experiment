define [
  'angular'
  'angular_ui_router'
  'templates'
  'common/fieldmatch/fieldmatch'
], ->
  module = angular.module 'app.states.user', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'common.fieldmatch.directive'
    'app.states.user.resource'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user",
      templateUrl: "app/states/user/list/list"
      url: "/user"
      controller: "UserCtrl"