define(['angular', 'app/states/user/details/details-module'], function() {
  var module;
  module = angular.module('app.states.user.details');
  return module.controller('UserDetailsCtrl', function($scope, $state, UserData) {
    $scope.user = UserData;
    return $scope.edit = function() {
      return $state.go("user.edit", {
        shortLink: UserData.shortLink
      });
    };
  });
});

//# sourceMappingURL=details-ctrl.js.map
