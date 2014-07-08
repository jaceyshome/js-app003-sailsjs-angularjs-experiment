define [
  'angular'
  'angular_resource'
  'app/config'
], (angular, angular_resource, config) ->
  appModule = angular.module 'app.states.user.service',['ngResource']
  appModule.factory "UserCreate", ["$resource", ($resource) ->
    $resource "#{config.baseUrl}/user/create", {},
      save:
        method: "POST"
        params: {}
        isArray: false
  ]
