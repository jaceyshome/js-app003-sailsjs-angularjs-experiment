define [
  'angular'
  'angular_ui_router'
  'templates'
  'common/fieldmatch/fieldmatch'
], ->
  module = angular.module 'app.states.signup', [
    'app.states.signup.service'
    'ui.router'
    'templates'
    'common.csrf.service'
    'common.utility'
    'common.fieldmatch.directive'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "signup",
      templateUrl: "app/states/user/userform"
      url: "/signup"
      controller: "SignupCtrl"