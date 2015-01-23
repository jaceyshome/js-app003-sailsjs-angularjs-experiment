define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.home', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "home",
      templateUrl: "app/states/home/home"
      url: "/"
      controller:"HomeCtrl"
      resolve:
        Projects: ($q, ProjectService) ->
          deferred = $q.defer()
          ProjectService.fetchProjects()
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve null
          deferred.promise
