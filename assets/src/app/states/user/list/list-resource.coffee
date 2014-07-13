define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.list.resource', ['ngResource']
  appModule.factory "UserListResource", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/list", {},
      get:
        method: "GET"
        params: {}
        isArray: false
      update:
        method: "PUT"
        params: {}
        isArray: false
      save:
        method: "POST"
        params: {}
        isArray: false
  ]
