define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.user', ['ui.router', 'templates', 'app.states.user.service', 'app.states.user.list', 'app.states.user.details', 'app.states.user.edit']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("user", {
      templateUrl: "app/states/user/user",
      url: "/user",
      controller: "UserCtrl"
    });
  });
});

//# sourceMappingURL=user-module.js.map
