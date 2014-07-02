define [
  'angular'
  ], ->
  module = angular.module 'app.states.text', []
  module.controller 'TextCtrl', ($scope, Screen) ->
    $scope.Screen = Screen
    $scope.$watch ()->
      Screen.screen
    , ()->
      $scope.screen = Screen.screen