define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var module;
  module = angular.module('common.navigation', ['common.csrf']);
  return module.directive('tntNavigation', function($http, $state, CSRF) {
    return {
      restrict: "A",
      scope: {},
      templateUrl: "common/navigation/navigation",
      link: function($scope, element, attrs) {
        return $scope.logout = function() {
          return CSRF.get().then(function(data) {
            return $http.post("" + config.baseUrl + "/session/destroy", {
              _csrf: data._csrf
            }).then(function(result) {
              return $state.go("login");
            })["catch"](function(err) {
              return console.log("log out fail");
            });
          });
        };
      }
    };
  });
});

//# sourceMappingURL=navigation.js.map
