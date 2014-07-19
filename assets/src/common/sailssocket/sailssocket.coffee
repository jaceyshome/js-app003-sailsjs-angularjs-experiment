define [
  'angular'
  'angular_sails'
], ->
  module = angular.module 'common.sailssocket', [
    'sails.io'
  ]
  module.factory 'SailsSocket', (sailsSocketFactory, $log)->
    service = sailsSocketFactory({
      reconnectionAttempts: 10
    })
    $log.debug("Connecting to Sails.js...")

    service.connect()
    console.log "sails connect", service
    service
