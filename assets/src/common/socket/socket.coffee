define [
  'angular'
], ->
  module = angular.module 'common.socket', [
    'common.sailsio'
  ]
  module.factory 'Socket', (SailsIo, $log)->
    service = SailsIo({
      reconnectionAttempts: 10
    })
    $log.debug("Connecting to Sails.js...")

#    service
    service.connect()