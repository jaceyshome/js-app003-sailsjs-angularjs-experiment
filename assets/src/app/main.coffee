define [
  'angular'
  'angular_ui_router'
  'app/states/intro/main'
  'app/states/text/main'
  'app/states/video/main'
  'app/states/hidden/main'
  'common/bookmark/main'
  'common/navigation/main'
  'common/structure/main'
  'common/screen/main'
  'common/text/main'
  'common/video/main'
  'templates'
  ], ->
  module = angular.module 'app', [
    'app.states.intro'
    'app.states.text'
    'app.states.video'
    'app.states.hidden'
    'common.bookmark'
    'common.navigation'
    'common.scorm'
    'common.structure'
    'common.screen'
    'common.text.service'
    'common.text.directive'
    'common.video.directive'
    'common.video.service'
    'templates'
    'ui.router'
  ]
  module.config ($locationProvider, $stateProvider)->
    #$locationProvider.html5Mode true
    $stateProvider.state "intro",
      templateUrl: "app/states/intro/main"
      controller:"IntroCtrl"
    $stateProvider.state "video",
      templateUrl: "app/states/video/main"
      controller:"VideoCtrl"
    $stateProvider.state "text",
      templateUrl: "app/states/text/main"
      controller:"TextCtrl"
    $stateProvider.state "hidden",
      templateUrl: "app/states/hidden/main"
      controller:"HiddenCtrl"

  module.controller 'MainCtrl', ($scope, $rootScope, Structure, Text, Scorm, Bookmark, Video, $state, Screen) ->
    $scope.Video = Video
    $scope.ready = false
    Video.init()
    .then Scorm.init
    .then Structure.load
    .then Bookmark.load
    .then Text.load
    .then ->
      $scope.ready = true
      Screen.first()

    $scope.$watch ->
      Screen.screen
    , (screen)->
      if screen?
        if Video.firstPlay is false
          Video.pause()
          Video.seek 0
        Video.setVisible false
        Video.resetAspectRatio()
        Video.setSrc "assets/media/black.mp4"
        Video.play()
        Video.pause()
        if screen.data? and screen.data.video?
          Video.setVisible true
          if screen.data.video.width? and screen.data.video.height?
            Video.setAspectRatio(screen.data.video.width, screen.data.video.height)
          Video.setCaptions screen.data.video.captions
          Video.setSrc screen.data.video.src
          if screen.data.video.autoplay
            Video.play()

