define(['angular'], function() {
  var module;
  module = angular.module('common.clickbtn', []);
  return module.directive('ClickBtn', function($rootScope) {
    return {
      restrict: "A",
      link: function($scope, element, attrs) {
        element.attr("onclick", "return false;");
        return element.attr("href", "JavaScript:void(0);");
      }
    };
  });
});

//# sourceMappingURL=clickbtn.js.map
