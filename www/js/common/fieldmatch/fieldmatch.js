define(['angular'], function() {
  var module;
  module = angular.module('common.fieldmatch.directive', []);
  return module.directive('fieldMatch', function($parse) {
    return {
      scope: {},
      restrict: "A",
      require: "?ngModel",
      link: function($scope, element, attrs, ctrl) {
        var init, validator;
        init = function() {
          if (!ctrl) {
            return;
          }
          ctrl.$parsers.unshift(validator);
          ctrl.$formatters.push(validator);
          return attrs.$observe('fieldMatch', function() {
            return validator(ctrl.$viewValue);
          });
        };
        validator = function(val) {
          ctrl.$setValidity('match', val === attrs['fieldMatch']);
          return val;
        };
        return init();
      }
    };
  });
});

//# sourceMappingURL=fieldmatch.js.map
