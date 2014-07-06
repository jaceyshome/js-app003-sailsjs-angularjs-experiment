define [
  'angular'
  'angular_ui_router'
  'app/states/home/home-ctrl'
], ->
  module = angular.module 'app', [
    'templates'
    'ui.router'
    'app.states.home'
  ]
  module.config ($locationProvider, $stateProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/home')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

  module
