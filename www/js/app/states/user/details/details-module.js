define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.user.details', ['ui.router', 'templates', 'common.utility', 'app.states.user.service']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("user.details", {
      parent: 'user',
      url: "/details/:shortLink",
      views: {
        'userChildView@user': {
          templateUrl: "app/states/user/details/details",
          controller: "UserDetailsCtrl"
        }
      },
      resolve: {
        UserData: function($q, $stateParams, UserService) {
          var deferred;
          deferred = $q.defer();
          if (!$stateParams.shortLink) {
            UserService.goToDefault();
            return deferred.resolve(void 0);
          }
          UserService.fetchUser({
            shortLink: $stateParams.shortLink
          }).then(function(result) {
            return deferred.resolve(result);
          })["catch"](function() {
            return deferred.resolve(void 0);
          });
          return deferred.promise;
        }
      }
    });
  });
});

//# sourceMappingURL=details-module.js.map
