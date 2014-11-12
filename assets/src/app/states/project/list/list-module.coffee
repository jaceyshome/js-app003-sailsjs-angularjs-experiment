define [
  'angular'
  'angular_ui_router'
  'templates'
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
        'projectChildView@user':
          templateUrl: "app/states/project/list/list"
          controller: "ProjectListCtrl"
      resolve:
        ProjectsData: ($q, ProjectService) ->
          deferred = $q.defer()
          ProjectService.listProjects()
          .then (result)->
            deferred.resolve result
          .catch ->
            ProjectService.goToDefault()
            deferred.resolve null
          deferred.promise