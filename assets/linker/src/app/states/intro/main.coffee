define [
  'angular'
  ], ->
  module = angular.module 'app.states.intro', []
  module.controller 'IntroCtrl', ($scope, Screen) ->
    $scope.Screen = Screen
    $scope.$watch ()->
      Screen.screen
    , ()->
      $scope.screen = Screen.screen
