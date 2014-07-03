define [
  'angular'
  'common/video/main'
  'common/videocontrols/main'
  'common/timecode/main'
  ], ->
  module = angular.module 'app.states.video', [
    'common.videocontrols'
  ]
  module.controller 'VideoCtrl', ($scope, Video, Screen) ->
    $scope.Screen = Screen
    $scope.$watch ()->
      Screen.screen
    , ()->
      $scope.screen = Screen.screen
      $scope.ended = false
      Video.ended.addOnce ->
        $scope.ended = true
