define [
  'angular'
], (angular) ->
  appModule = angular.module 'common.utility', []
  appModule.factory "Utility", () ->
    service = {}
    service.handleServerError = (err)->
      msg = ''
      for error in err.data.errors
        msg += error.toString()
      console.log "ERROR! ",msg



    service
