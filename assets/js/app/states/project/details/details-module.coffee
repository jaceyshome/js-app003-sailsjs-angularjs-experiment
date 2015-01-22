define [
  'angular'
  'angular_ui_router'
  'app/states/project/details/projectstages/projectstages'
  'app/states/project/details/stagetasks/stagetasks'
], ->
  module = angular.module 'app.states.project.details', [
    'ui.router'
    'templates'
    'app.states.project.details.projectstages'
    'app.states.project.details.stagetasks'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "project.details",
      parent: 'project'
      url: "/details/:id/s/:shortLink"
      views:
        'projectChildView@project':
          templateUrl: "app/states/project/details/details"
          controller: "ProjectDetailsCtrl"
      resolve:
        Project: ($q, $stateParams, ProjectService) ->
          deferred = $q.defer()
          unless $stateParams.shortLink and $stateParams.id
            ProjectService.goToDefault()
            deferred.resolve undefined
          ProjectService.fetchProject({id:$stateParams.id,shortLink:$stateParams.shortLink})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise