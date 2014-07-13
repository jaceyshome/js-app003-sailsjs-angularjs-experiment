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
