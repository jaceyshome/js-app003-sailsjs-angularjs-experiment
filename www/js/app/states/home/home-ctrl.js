define(['app/states/home/home-module'], function() {
  var module;
  module = angular.module('app.states.home');
  return module.controller('HomeCtrl', function($scope, Projects, ProjectService, $state) {
    var init, initPanelListSettings;
    $scope.projects = Projects;
    $scope.panelsListSettings = null;
    init = function() {
      return initPanelListSettings();
    };
    initPanelListSettings = function() {
      return $scope.panelsListSettings = {
        data: Projects
      };
    };
    return init();
  });
});

//# sourceMappingURL=home-ctrl.js.map
