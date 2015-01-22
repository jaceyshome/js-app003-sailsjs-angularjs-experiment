define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.project.list', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project.list",
      parent: 'project'
      url: "/list"
      views:
        'projectChildView@project':
          templateUrl: "app/states/project/list/list"
          controller: "ProjectListCtrl"
      resolve:
        Projects: ($q, ProjectService) ->
          deferred = $q.defer()
          ProjectService.fetchProjects()
          .then (result)->
            deferred.resolve result
          .catch ->
            ProjectService.goToDefault()
            deferred.resolve null
          deferred.promise