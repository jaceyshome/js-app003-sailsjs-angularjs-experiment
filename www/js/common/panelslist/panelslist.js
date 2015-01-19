define(['angular'], function() {
  var module;
  module = angular.module('common.panelslist', []);
  return module.directive('panelsList', function() {
    return {
      restrict: "A",
      scope: {
        settings: "="
      },
      replace: true,
      templateUrl: "common/panelslist/panelslist",
      link: function($scope, $element, $attrs) {
        var init;
        init = function() {
          return void 0;
        };
        return init();
      }
    };
  });
});

//# sourceMappingURL=panelslist.js.map
