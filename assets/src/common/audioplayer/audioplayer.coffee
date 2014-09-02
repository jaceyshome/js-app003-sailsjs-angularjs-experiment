define [
  'sound'
  'angular'
  'angular_resource'
], ->
  module = angular.module "common.audioplayer" , [
    'app.values'
  ]

  module.factory "AudioPlayer", () ->
    soundManagerReady = false
    player = null
    audioPlayer = {}
    audioPlayer.init = (flashPath)->
      flashPath = flashPath || 'assets/swfs'
      return if soundManagerReady
      soundManager.setup
        url: flashPath
        flashVersion: 9
        preferFlash: false
        debugMode: false
        waitForWindowLoad: false #if true use window.onload function to trigger setup
        onready: ->
          soundManagerReady = true
          audioPlayer.play({
            id:0
            url:'assets/demo.mp3'
          })
      return

    audioPlayer.play = (config)->
      return unless config
      soundManager.stopAll() unless config.stopAll is false
      player = soundManager.createSound({
        id: config.id || 'demo'
        url: config.url || 'assets'
        autoLoad: config.autoLoad || true
        autoPlay: config.autoPlay || true
        stream: config.stream || true
        onfinish: ()->
          config.onFinish?()
        onload: (success)->
          config.onLoad?()
        whileplaying: ()->
          config.onPlaying?()
      })
      player.play()
      return

    audioPlayer
