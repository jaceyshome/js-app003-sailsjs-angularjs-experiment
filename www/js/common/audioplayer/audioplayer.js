define(['sound', 'angular', 'angular_resource'], function() {
  var module;
  module = angular.module("common.audioplayer", ['app.values']);
  return module.factory("AudioPlayer", function() {
    var audioPlayer, player, soundManagerReady;
    soundManagerReady = false;
    player = null;
    audioPlayer = {};
    audioPlayer.init = function(flashPath) {
      flashPath = flashPath || 'assets/swfs';
      if (soundManagerReady) {
        return;
      }
      soundManager.setup({
        url: flashPath,
        flashVersion: 9,
        preferFlash: false,
        debugMode: false,
        waitForWindowLoad: false,
        onready: function() {
          soundManagerReady = true;
          return audioPlayer.play({
            id: 0,
            url: 'assets/demo.mp3'
          });
        }
      });
    };
    audioPlayer.play = function(config) {
      if (!config) {
        return;
      }
      if (config.stopAll !== false) {
        soundManager.stopAll();
      }
      player = soundManager.createSound({
        id: config.id || 'demo',
        url: config.url || 'assets',
        autoLoad: config.autoLoad || true,
        autoPlay: config.autoPlay || true,
        stream: config.stream || true,
        onfinish: function() {
          return typeof config.onFinish === "function" ? config.onFinish() : void 0;
        },
        onload: function(success) {
          return typeof config.onLoad === "function" ? config.onLoad() : void 0;
        },
        whileplaying: function() {
          return typeof config.onPlaying === "function" ? config.onPlaying() : void 0;
        }
      });
      player.play();
    };
    return audioPlayer;
  });
});

//# sourceMappingURL=audioplayer.js.map
