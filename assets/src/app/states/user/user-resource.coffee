define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.user.list.resource',['ngResource']
  appModule.factory "UserResource", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/list", {},
      get:
        method: "GET"
        params: {}
        isArray: false
  ]
