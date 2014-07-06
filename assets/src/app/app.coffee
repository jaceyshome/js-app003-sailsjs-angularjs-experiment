define [
  'angular'
  'angular_ui_router'
  'app/states/home/home-ctrl'
], ->
  module = angular.module 'app', [
    'ui.router'
    'app.states.home'
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

  module
