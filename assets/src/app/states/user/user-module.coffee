define [
  'angular'
  'angular_ui_router'
  'templates'
  'common/fieldmatch/fieldmatch'
], ->
  module = angular.module 'app.states.user', [
    'app.states.user.service'
    'ui.router'
    'templates'
    'common.csrf.service'
    'common.utility'
    'common.fieldmatch.directive'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user",
      templateUrl: "app/states/user/userform"
      url: "/user"
      controller: "UserCtrl"