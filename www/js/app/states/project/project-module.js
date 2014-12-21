define(['angular', 'angular_ui_router'], function() {
  var module;
  module = angular.module('app.states.project', ['ui.router', 'templates', 'app.states.project.service', 'app.states.project.new', 'app.states.project.list', 'app.states.project.edit', 'app.states.project.details']);
  return module.config(function($stateProvider) {
    return $stateProvider.state("project", {
      templateUrl: "app/states/project/project",
      url: "/project",
      controller: "ProjectCtrl"
    });
  });
});

//# sourceMappingURL=project-module.js.map
