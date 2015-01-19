define(['angular', 'angular_animate', 'jquery'], function() {
  var module;
  module = angular.module('common.animatespark', ['ngAnimate']);
  return module.animation('.animate-spark', function() {
    return {
      enter: function(element, done) {
        jQuery(element).fadeOut(400, done);
        return done();
      },
      leave: function(element, done) {
        done();
        return true;
      }
    };
  });
});

//# sourceMappingURL=main.js.map
