define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.signup', [
    'ui.router'
    'templates'
    'common.utility'
    'common.fieldmatch.directive'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "signup",
      templateUrl: "app/states/user/form/form"
      url: "/signup"
      controller: "SignupCtrl"