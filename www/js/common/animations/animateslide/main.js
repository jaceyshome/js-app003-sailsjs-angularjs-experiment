define(['angular', 'angular_animate', 'jquery'], function() {
  var module;
  module = angular.module('common.animateslide', ['ngAnimate']);
  return module.animation('.animate-slide', function() {
    return {
      enter: function(element, done) {
        jQuery(element).slideDown(done);
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).stop();
          }
        };
      },
      leave: function(element, done) {
        jQuery(element).slideUp(done);
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).stop();
          }
        };
      },
      move: function(element, done) {
        return done();
      },
      beforeAddClass: function(element, className, done) {
        if (className === "ng-hide") {
          jQuery(element).slideUp(done);
        } else {
          done();
        }
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).stop();
          }
        };
      },
      addClass: function(element, className, done) {
        return done();
      },
      beforeRemoveClass: function(element, className, done) {
        return done();
      },
      removeClass: function(element, className, done) {
        if (className === "ng-hide") {
          jQuery(element).slideDown(done);
        } else {
          done();
        }
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).stop();
          }
        };
      },
      allowCancel: function(element, event, className) {
        return true;
      }
    };
  });
});

//# sourceMappingURL=main.js.map
