define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.user.service',['ngResource']
  appModule.factory "User", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user", {},
      get:
        method: "GET"
        params: {}
        isArray: false
      save:
        method: "POST"
        params: {}
        isArray: false
      update:
        method: "PUT"
        params: {}
        isArray: false
  ]
