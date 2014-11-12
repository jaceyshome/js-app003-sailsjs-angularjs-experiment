define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.project', [
    'ui.router'
    'templates'
    'app.states.project.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project",
      templateUrl: "app/states/project/project"
      url: "/project"
      controller: "ProjectCtrl"
