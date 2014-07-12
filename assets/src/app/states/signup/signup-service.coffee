define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.signup.service', ['ngResource']
  appModule.factory "SignupService", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/create", {},
      save:
        method: "POST"
        params: {}
        isArray: false
  ]
