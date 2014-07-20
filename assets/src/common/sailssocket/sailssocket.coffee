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
      return unless firstRun
      service.io = sailsSocketFactory({
        reconnectionAttempts: 10
      })
      $log.debug("Connecting to Sails.js...")
      service.io.connect()
      deferred.promise

    service
