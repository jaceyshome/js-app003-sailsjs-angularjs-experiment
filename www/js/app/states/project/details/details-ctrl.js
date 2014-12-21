define(['angular', 'app/states/project/details/details-module'], function() {
  var module;
  module = angular.module('app.states.project.details');
  return module.controller('ProjectDetailsCtrl', function($scope, $state, ProjectData) {
    $scope.project = ProjectData;
    return $scope.edit = function() {
      return $state.go("project.edit", {
        shortLink: ProjectData.shortLink
      });
    };
  });
});

//# sourceMappingURL=details-ctrl.js.map
