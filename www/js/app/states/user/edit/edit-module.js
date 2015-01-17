define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.user.edit', ['ui.router', 'templates', 'common.utility', 'common.fieldmatch', 'app.states.user.service']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("user.edit", {
      parent: 'user',
      url: "/edit/:shortLink",
      views: {
        'userChildView@user': {
          templateUrl: "app/states/user/form/form",
          controller: "UserEditCtrl"
        }
      },
      resolve: {
        UserData: function($q, $stateParams, UserService) {
          var deferred;
          deferred = $q.defer();
          if (!$stateParams.shortLink) {
            UserService.goToDefault();
            deferred.resolve(void 0);
          }
          UserService.getUserDetail({
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

//# sourceMappingURL=edit-module.js.map
