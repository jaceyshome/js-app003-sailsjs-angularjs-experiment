define(['app/states/user/edit/edit-module', 'app/states/user/user-service'], function() {
  var module;
  module = angular.module('app.states.user.edit');
  return module.controller('UserEditCtrl', function($scope, $state, UserData, UserService) {
    $scope.user = angular.copy(UserData);
    $scope.formTitle = "Edit User";
    $scope.submitBtnText = "Save";
    return $scope.sumbit = function() {
      return UserService.updateUser($scope.user);
    };
  });
});

//# sourceMappingURL=edit-ctrl.js.map
