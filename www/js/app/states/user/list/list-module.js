define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.user.list', ['ui.router', 'templates', 'common.csrf', 'common.utility', 'app.states.user.service']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("user.list", {
      parent: 'user',
      url: "/list",
      views: {
        'userChildView@user': {
          templateUrl: "app/states/user/list/list",
          controller: "UserListCtrl"
        }
      },
      resolve: {
        UsersData: function($q, UserService) {
          var deferred;
          deferred = $q.defer();
          UserService.listUsers().then(function(result) {
            return deferred.resolve(result);
          })["catch"](function() {
            UserService.goToDefault();
            return deferred.resolve(null);
          });
          return deferred.promise;
        }
      }
    });
  });
});

//# sourceMappingURL=list-module.js.map
