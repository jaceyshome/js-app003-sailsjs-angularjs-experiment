define [
  'angular'
  'data_validations'
], (angular, data_validations) ->
  console.log "validations", data_validations
  appModule = angular.module 'common.validation', []
  appModule.factory "ValidationService", ($q)->
    service = {}
    service.validations = null


    service
