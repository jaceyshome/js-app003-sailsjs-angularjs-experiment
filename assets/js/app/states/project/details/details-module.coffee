define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.project.details', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project.details",
      parent: 'project'
      url: "/details/:shortLink"
      views:
        'projectChildView@project':
          templateUrl: "app/states/project/details/details"
          controller: "ProjectDetailsCtrl"
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