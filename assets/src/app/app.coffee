define [
  'angular'
  'angular_ui_router'
  'app/config'
  'bootstrap'
  'jquery'
  'common/utility/utility'
  'common/csrf/csrf'
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
    $urlRouterProvider.otherwise('/user/list')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

  module
