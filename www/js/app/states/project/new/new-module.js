define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.project.new', ['ui.router', 'templates']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project.new", {
      parent: 'project',
      url: "/new",
      views: {
        'projectChildView@project': {
          templateUrl: "app/states/project/new/new",
          controller: "ProjectNewCtrl"
        }
      }
    });
  });
});

//# sourceMappingURL=new-module.js.map
