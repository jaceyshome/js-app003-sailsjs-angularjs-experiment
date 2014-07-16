define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.message.service', []
  appModule.factory "messageService", () ->
    service = {}

    service.handleValidationErrorMsg = (errs)->
      msg = ""
      for err in errs
        msg += err.message + "/n"
      msg

    service.handleDataErrorMsg = (err)->
      console.log err
      msg = ""
      msg += "The name " if err.indexOf('name') isnt -1
      msg += "already exists./n" if err.indexOf('ER_DUP_ENTRY') isnt -1
      msg

    service
