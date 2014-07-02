define [
  'angular'
  ], ->
  module = angular.module 'app.states.hidden', []
  module.controller 'HiddenCtrl', ($scope, Screen) ->
    $scope.Screen = Screen
    $scope.$watch ()->
      Screen.screen
    , ()->
      $scope.screen = Screen.screen
