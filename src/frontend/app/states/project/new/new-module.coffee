define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.project.new', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project.new",
      parent: 'project'
      url: "/new"
      views:
        'projectChildView@project':
          templateUrl: "app/states/project/new/new"
          controller: "ProjectNewCtrl"
