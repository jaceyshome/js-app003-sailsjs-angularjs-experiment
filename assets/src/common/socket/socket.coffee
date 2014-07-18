define [
  'angular'
  'socket_io'
  'angular_socket_io'
], ->
  module = angular.module 'common.socket', [
    'sails.io'
  ]
  module.factory 'Socket', (sailsSocketFactory, $log)->
    service = sailsSocketFactory({ reconnectionAttempts: 10 })
    $log.debug("Connecting to Sails.js...")

    service.connect()