define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.login', ['ui.router', 'templates', 'app.states.login.service']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("login", {
      templateUrl: "app/states/login/login",
      url: "/login",
      controller: "LoginCtrl"
    });
  });
});

//# sourceMappingURL=login-module.js.map
