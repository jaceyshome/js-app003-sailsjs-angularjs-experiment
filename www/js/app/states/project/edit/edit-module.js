define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.project.edit', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project.edit", {
      parent: 'project',
      url: "/edit/:shortLink",
      views: {
        'projectChildView@project': {
          templateUrl: "app/states/project/edit/edit",
          controller: "ProjectEditCtrl"
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

//# sourceMappingURL=edit-module.js.map
