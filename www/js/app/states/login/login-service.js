define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var appModule;
  appModule = angular.module('app.states.login.service', ['common.csrf']);
  return appModule.factory("LoginService", function($http, $q, CSRF) {
    var service;
    service = {};
    service.login = function(user) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        var loginUser;
        loginUser = {
          name: user.name,
          password: user.password,
          _csrf: data._csrf
        };
        return $http.post("" + config.baseUrl + "/session/create", loginUser).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    return service;
  });
});

//# sourceMappingURL=login-service.js.map
