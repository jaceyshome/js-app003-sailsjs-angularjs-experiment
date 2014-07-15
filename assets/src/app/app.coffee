define [
  'angular'
  'angular_ui_router'
  'app/config'
  'bootstrap'
  'jquery'
  'common/csrf/csrf'
  'common/utility/utility'
  'common/fieldmatch/fieldmatch'
  'app/states/home/home-ctrl'
  'app/states/user/user-ctrl'
  'app/states/signup/signup-ctrl'
], ->
  module = angular.module 'app', [
    'ui.router'
    'app.states.home'
    'app.states.user'
    'app.states.signup'
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/signin')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

  module
