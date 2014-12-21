define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.project.edit', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project.edit",
      parent: 'project'
      url: "/edit/:shortLink"
      views:
        'projectChildView@project':
          templateUrl: "app/states/project/edit/edit"
          controller: "ProjectEditCtrl"
      resolve:
        ProjectData: ($q, $stateParams, ProjectService) ->
          deferred = $q.defer()
          unless $stateParams.shortLink
            ProjectService.goToDefault()
            deferred.resolve undefined
          ProjectService.getProjectDetail({shortLink:$stateParams.shortLink})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise