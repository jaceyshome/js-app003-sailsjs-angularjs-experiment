define(['angular'], function() {
  var module;
  module = angular.module('common.navigation', []);
  return module.directive('tntNavigation', function($rootScope, Screen) {
    return {
      restrict: "A",
      scope: {},
      templateUrl: "common/navigation/main",
      link: function($scope, element, attrs) {
        $scope.Screen = Screen;
        return $scope.$watch(function() {
          return Screen.screen;
        }, function(screen) {
          return $scope.screen = screen;
        });
      }
    };
  });
});

//# sourceMappingURL=navigation.js.map
