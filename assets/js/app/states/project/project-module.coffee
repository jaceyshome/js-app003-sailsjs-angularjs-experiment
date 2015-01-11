define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.project', [
    'ui.router'
    'templates'
    'app.states.project.list'
    'app.states.project.details'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project",
      templateUrl: "app/states/project/project"
      url: "/project"
      controller: "ProjectCtrl"
