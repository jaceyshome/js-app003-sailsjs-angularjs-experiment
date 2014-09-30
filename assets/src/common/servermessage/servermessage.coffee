define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.servermessage.service', [
    'toaster'
  ]
  appModule.factory "ServerMessageService", (toaster) ->
    service = {}

    service.handleServerError = (err)->
      msg = ''
      if err.data?.errors?
        for error in err.data.errors
          if typeof error is 'string'
            msg += handleErrorMsg(error)
          if error.ValidationError
            msg += handlerValidationError(error.ValidationError)
      else
        msg += handleServerDefaultError()
      showError(msg)
      return

    handlerValidationError = (error)->
      return handleServerDefaultError()

    handleErrorMsg = (err)->
      msg = ""
      msg += handleDuplicateEntry(err) if err.indexOf('ER_DUP_ENTRY') isnt -1
      msg

    handleDuplicateEntry = (err)->
      strings = err.match(/(['"])[^'"]*\1/g)
      value = strings[0]
      key = strings[1].split('_')[0].replace('\'','')
      return key+":"+value+" already exists"

    handleServerDefaultError = ()->
      return "Internal Server Error, please try again"

    showError = (msg)->
      toaster.pop('error', "server error", msg)

    service
