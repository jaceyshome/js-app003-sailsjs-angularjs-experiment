define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource,config) ->
  appModule = angular.module 'common.csrf', []
  appModule.factory "CSRF", ($http, $q) ->
    service = {}

    service.get = ()->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/csrfToken")
      .then (result)->
        deferred.resolve result.data
      .catch ->
        deferred.resolve undefined
      deferred.promise

    service
