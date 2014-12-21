define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.project.details', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project.details", {
      parent: 'project',
      url: "/details/:shortLink",
      views: {
        'projectChildView@project': {
          templateUrl: "app/states/project/details/details",
          controller: "ProjectDetailsCtrl"
        }
      },
      resolve: {
        ProjectData: function($q, $stateParams, ProjectService) {
          var deferred;
          deferred = $q.defer();
          if (!$stateParams.shortLink) {
            ProjectService.goToDefault();
            deferred.resolve(void 0);
          }
          ProjectService.getProjectDetail({
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
