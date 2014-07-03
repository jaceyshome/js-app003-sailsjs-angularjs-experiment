define [
  'angular'
  ], (angular, jsyaml)->
  module = angular.module 'common.structure', []
  module.factory 'Structure', ($http, $q) ->
    service = {}
    service.load = (callback)->
      console.log "loading"
      deferred = $q.defer()
      $http.get('assets/data/structure.json')
      .success (data, status) ->
        console.log "load success"
        service.data = data
        deferred.resolve data
      if callback
        deferred.promise.then callback
      deferred.promise
    return service