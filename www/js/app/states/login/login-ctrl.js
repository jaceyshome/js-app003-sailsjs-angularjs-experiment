define(['app/states/login/login-module', 'app/states/login/login-service'], function() {
  var module;
  module = angular.module('app.states.login');
  return module.controller('LoginCtrl', function($scope, $state, LoginService, UserService, Validation, MessageService) {
    var init;
    $scope.user = [];
    init = function() {
      return $scope.attributes = Validation.getModelAttributes('user', ['name', 'password']);
    };
    $scope.sumbit = function() {
      var message;
      message = Validation.validate({
        values: $scope.user,
        attributes: $scope.attributes
      });
      if (message) {
        MessageService.showError(message);
        return;
      }
      return LoginService.login($scope.user).then(function(result) {
        if (result) {
          return $state.go('home');
        } else {
          return MessageService.showError('Login fail');
        }
      });
    };
    $scope.goToSignup = function() {
      return $state.go("signup");
    };
    return init();
  });
});

//# sourceMappingURL=login-ctrl.js.map
