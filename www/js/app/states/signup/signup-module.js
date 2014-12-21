define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.signup', ['ui.router', 'templates', 'common.utility', 'common.fieldmatch.directive', 'app.states.user.service']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("signup", {
      templateUrl: "app/states/user/form/form",
      url: "/signup",
      controller: "SignupCtrl"
    });
  });
});

//# sourceMappingURL=signup-module.js.map
