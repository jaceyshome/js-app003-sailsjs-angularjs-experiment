define(['app/states/user/list/list-module', 'app/states/user/user-service'], function() {
  var module;
  module = angular.module('app.states.user.list');
  return module.controller('UserListCtrl', function($scope, $state, UsersData, UserService) {
    $scope.users = UsersData;
    $scope.show = function(user) {
      return $state.go("user.details", {
        shortLink: user.shortLink
      });
    };
    $scope.destroy = function(user) {
      return UserService.destroyUser(user).then(function(result) {
        if (result) {
          return $scope.users.splice($scope.users.indexOf(user), 1);
        } else {
          return console.log("servers error");
        }
      });
    };
    return $scope.edit = function(user) {
      return $state.go("user.edit", {
        shortLink: user.shortLink
      });
    };
  });
});

//# sourceMappingURL=list-ctrl.js.map
