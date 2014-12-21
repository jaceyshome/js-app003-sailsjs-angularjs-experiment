define(['app/states/home/home-module'], function() {
  var module;
  module = angular.module('app.states.home');
  return module.controller('HomeCtrl', function($scope, UsersData, UserService, $state) {
    return $scope.users = UsersData;
  });
});

//# sourceMappingURL=home-ctrl.js.map
