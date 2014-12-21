define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config, csrf) {
  var appModule;
  appModule = angular.module('app.states.user.service', ['common.csrf']);
  return appModule.factory("UserService", function($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket) {
    var handleErrorMsg, service, _user, _users;
    _users = null;
    _user = null;
    $sailsSocket.subscribe('user', function(data) {
      return console.log("user msg", data);
    });
    $sailsSocket.get('/user/subscribe').success(function() {
      return console.log("get user subscribe");
    });
    service = {};
    service.goToDefault = function() {
      return $state.go('/');
    };
    service.getUser = function() {
      return _user;
    };
    service.setUser = function(user) {
      return _user = user;
    };
    service.listUsers = function() {
      var deferred;
      deferred = $q.defer();
      if (_users) {
        deferred.resolve(_users);
      } else {
        $http.get("" + config.baseUrl + "/user/all").then(function(result) {
          _users = result.data;
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          deferred.resolve(null);
          return handleErrorMsg(err);
        });
      }
      return deferred.promise;
    };
    service.createUser = function(user) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        var newUser;
        newUser = {
          name: user.name,
          email: user.email,
          password: user.password,
          _csrf: data._csrf
        };
        return $http.post("" + config.baseUrl + "/user/create", newUser).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    service.getUserDetail = function(user) {
      var deferred;
      deferred = $q.defer();
      if (angular.equals(user, _user)) {
        deferred.resolve(user);
      }
      $http.get("" + config.baseUrl + "/user/specifics/" + user.shortLink).then(function(result) {
        return deferred.resolve(result.data);
      })["catch"](function(err) {
        handleErrorMsg(err);
        return deferred.resolve(null);
      });
      return deferred.promise;
    };
    service.updateUser = function(user) {
      var deferred;
      deferred = $q.defer();
      return CSRF.get().then(function(data) {
        var editingUser;
        editingUser = {
          id: user.id,
          shortLink: user.shortLink,
          name: user.name,
          email: user.email,
          password: user.password,
          _csrf: data._csrf
        };
        $http.put("" + config.baseUrl + "/user/update", editingUser).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
        return deferred.promise;
      });
    };
    service.destroyUser = function(user) {
      var deferred;
      deferred = $q.defer();
      CSRF.get().then(function(data) {
        var deletingUser;
        deletingUser = {
          id: user.id,
          shortLink: user.shortLink,
          _csrf: data._csrf
        };
        return $http.post("" + config.baseUrl + "/user/destroy", deletingUser).then(function(result) {
          return deferred.resolve(result.data);
        })["catch"](function(err) {
          handleErrorMsg(err);
          return deferred.resolve(null);
        });
      });
      return deferred.promise;
    };
    handleErrorMsg = function(err) {
      return MessageService.handleServerError(err);
    };
    return service;
  });
});

//# sourceMappingURL=user-service.js.map
