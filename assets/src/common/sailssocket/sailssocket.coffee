define [
  'angular'
  'angular_sails'
], ->
  module = angular.module 'common.sailssocket', [
    'sails.io'
  ]
  module.factory 'SailsSocket', (sailsSocketFactory, $q, $log )->
    firstRun = true
    service = {}

    service.init = ->
      deferred = $q.defer()
      return deferred.resolve service.io unless firstRun
      service.io = sailsSocketFactory({
        reconnectionAttempts: 10
        url:'/' #Jake: hack to solve the failing connection if url is not /
      })
      $log.debug("Connecting to Sails.js...")
      firstRun = false
      service.io.connect()
      .then (result)->
        deferred.resolve result
      .catch ->
        deferred.resolve null
      deferred.promise

    service
