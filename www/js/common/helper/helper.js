define(['angular'], function(angular) {
  var module;
  module = angular.module('common.helper', []);
  return module.factory('Helper', function() {
    var service;
    service = {};
    service.getViewportSize = function() {
      return {
        width: window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
        height: window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
      };
    };
    service.colorLuminance = function(hex, lum) {
      var c, i, rgb, _i;
      rgb = "#";
      hex = String(hex).replace(/[^0-9a-f]/gi, '');
      if (hex.length < 6) {
        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
      }
      lum = lum || 0;
      for (i = _i = 0; _i <= 2; i = _i += 1) {
        c = parseInt(hex.substr(i * 2, 2), 16);
        c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16);
        rgb += ("00" + c).substr(c.length);
      }
      return rgb;
    };
    service.parseUrlString = function() {
      var params, str;
      str = window.location.search;
      params = {};
      str.replace(new RegExp("([^?=&]+)(=([^&]*))?", "g"), function($0, $1, $2, $3) {
        params[$1] = $3;
      });
      return params;
    };
    return service;
  });
});

//# sourceMappingURL=helper.js.map
