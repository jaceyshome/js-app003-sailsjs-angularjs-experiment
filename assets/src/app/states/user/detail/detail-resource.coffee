define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.user.detail.resource', ['ngResource']
  appModule.factory "UserDetailResource", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/detail", {},
      get:
        method: "GET"
        params: {}
        isArray: false
  ]
