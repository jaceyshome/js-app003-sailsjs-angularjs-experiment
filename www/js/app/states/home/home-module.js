define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.home', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("home", {
      templateUrl: "app/states/home/home",
      url: "/",
      controller: "HomeCtrl",
      resolve: {
        UsersData: function($q, UserService) {
          var deferred;
          deferred = $q.defer();
          UserService.listUsers().then(function(result) {
            return deferred.resolve(result);
          })["catch"](function() {
            return deferred.resolve(null);
          });
          return deferred.promise;
        }
      }
    });
  });
});

//# sourceMappingURL=home-module.js.map
