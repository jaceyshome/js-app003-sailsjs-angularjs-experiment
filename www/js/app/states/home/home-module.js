define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.home', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("home", {
      templateUrl: "app/states/home/home",
      url: "/",
      controller: "HomeCtrl",
      resolve: {
        Projects: function($q, ProjectService) {
          var deferred;
          deferred = $q.defer();
          ProjectService.listProjects().then(function(result) {
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
