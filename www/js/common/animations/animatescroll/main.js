define(['angular', 'jquery'], function(angular) {
  var module;
  module = angular.module('common.animatescroll', []);
  return module.factory('AnimateScroll', function() {
    var service;
    service = {};
    service.scrollToElementTop = function(customSettings) {
      var defaultSettings, settings;
      defaultSettings = {
        element: void 0,
        runtime: 200,
        offset: 0,
        easing: "linear"
      };
      settings = {};
      angular.extend(settings, defaultSettings, customSettings);
      $("html, body").animate({
        scrollTop: settings.element.offset().top + settings.offset
      }, settings.runtime, settings.easing);
      return void 0;
    };
    service.scrollToPagePosition = function(position, runtime) {
      position = position || 0;
      runtime = runtime || 100;
      $("html, body").animate({
        scrollTop: position
      }, runtime);
      return void 0;
    };
    service.calculateScrollRunTime = function(toLocation, speed) {
      if (toLocation == null) {
        toLocation = 0;
      }
      if (speed == null) {
        speed = 0.1;
      }
      return parseInt(Math.abs($(document).scrollTop() - toLocation) * speed);
    };
    return service;
  });
});

//# sourceMappingURL=main.js.map
