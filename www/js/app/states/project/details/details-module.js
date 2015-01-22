define(['angular', 'angular_ui_router', 'app/states/project/details/projectstages/projectstages', 'app/states/project/details/stagetasks/stagetasks'], function() {
  var module;
  module = angular.module('app.states.project.details', ['ui.router', 'templates', 'app.states.project.details.projectstages', 'app.states.project.details.stagetasks']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project.details", {
      parent: 'project',
      url: "/details/:id/s/:shortLink",
      views: {
        'projectChildView@project': {
          templateUrl: "app/states/project/details/details",
          controller: "ProjectDetailsCtrl"
        }
      },
      resolve: {
        Project: function($q, $stateParams, ProjectService) {
          var deferred;
          deferred = $q.defer();
          if (!($stateParams.shortLink && $stateParams.id)) {
            ProjectService.goToDefault();
            deferred.resolve(void 0);
          }
          ProjectService.fetchProject({
            id: $stateParams.id,
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
