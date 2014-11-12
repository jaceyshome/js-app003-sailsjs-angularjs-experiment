define [
  'angular'
  'angular_ui_router'
  'templates'
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
        'userChildView@user':
          templateUrl: "app/states/project/edit/edit"
          controller: "ProjectEditCtrl"
      resolve:
        UserData: ($q, $stateParams, ProjectService) ->
          deferred = $q.defer()
          unless $stateParams.shortLink
            ProjectService.goToDefault()
            deferred.resolve undefined
          ProjectService.getUserDetail({shortLink:$stateParams.shortLink})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise