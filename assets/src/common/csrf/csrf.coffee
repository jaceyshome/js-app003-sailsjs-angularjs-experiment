define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.csrf.service', ['ngResource']
  appModule.factory "CSRF", ["$resource", ($resource) ->
    $resource "/csrfToken", {},
      get:
        method: "GET"
        params: {}
        isArray: false
  ]
