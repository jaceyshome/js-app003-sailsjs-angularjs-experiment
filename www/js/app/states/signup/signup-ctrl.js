define(['app/states/signup/signup-module'], function() {
  var module;
  module = angular.module('app.states.signup');
  return module.controller('SignupCtrl', function($scope, $state, UserService, Validation, MessageService) {
    var init;
    $scope.user = [];
    init = function() {
      $scope.formTitle = "Sign up";
      $scope.submitBtnText = "Save";
      return $scope.attributes = Validation.getModelAttributes('user', ['name', 'email', 'password', 'confirmPassword']);
    };
    $scope.sumbit = function() {
      var result;
      result = Validation.validate({
        values: $scope.user,
        attributes: $scope.attributes
      });
      if (result) {
        MessageService.showError(result.message);
        return;
      }
      return UserService.createUser($scope.user).then(function(result) {
        if (result) {
          UserService.setUser(result);
          return $state.go('home');
        }
      })["catch"](function(err) {
        return MessageService.handleServerDefaultError();
      });
    };
    return init();
  });
});

//# sourceMappingURL=signup-ctrl.js.map
