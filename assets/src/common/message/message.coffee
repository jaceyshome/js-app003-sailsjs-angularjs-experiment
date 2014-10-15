define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.message.service', [
    'toaster'
  ]
  appModule.factory "MessageService", (toaster) ->
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
      service.showError(msg)
      return

    service.showError = (msg)->
      toaster.pop('error', "server error", msg)

    service.handleServerDefaultError = ()->
      return "Internal Server Error, please try again"

    handlerValidationError = (error)->
      return service.handleServerDefaultError()

    handleErrorMsg = (err)->
      msg = ""
      msg += handleDuplicateEntry(err) if err.indexOf('ER_DUP_ENTRY') isnt -1
      msg

    handleDuplicateEntry = (err)->
      strings = err.match(/(['"])[^'"]*\1/g)
      value = strings[0]
      key = strings[1].split('_')[0].replace('\'','')
      return key+":"+value+" already exists"

    service
