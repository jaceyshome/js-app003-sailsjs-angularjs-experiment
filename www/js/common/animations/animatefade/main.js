define(['angular', 'angular_animate', 'jquery'], function() {
  var module;
  module = angular.module('common.animatefade', ['ngAnimate']);
  return module.animation('.animate-fade', function() {
    return {
      enter: function(element, done) {
        jQuery(element).fadeIn(200, done);
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).stop();
          }
        };
      },
      leave: function(element, done) {
        jQuery(element).fadeOut(100, done);
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
          jQuery(element).fadeOut(200, done);
        } else {
          done();
        }
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).hide();
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
          jQuery(element).fadeIn(200, done);
        } else {
          done();
        }
        return function(cancelled) {
          if (cancelled) {
            return jQuery(element).show();
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
