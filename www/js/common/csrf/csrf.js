define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var appModule;
  appModule = angular.module('common.csrf', []);
  return appModule.factory("CSRF", function($http, $q) {
    var service;
    service = {};
    service.get = function() {
      var deferred;
      deferred = $q.defer();
      $http.get("" + config.baseUrl + "/csrfToken").then(function(result) {
        return deferred.resolve(result.data);
      })["catch"](function() {
        return deferred.resolve(void 0);
      });
      return deferred.promise;
    };
    return service;
  });
});

//# sourceMappingURL=csrf.js.map
