define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.user.service',['ngResource']
  appModule.factory "UserService", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/detail", {},
      get:
        method: "GET"
        params: {}
        isArray: false
  ]
