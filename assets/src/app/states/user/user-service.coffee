define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.user.service', [
    'common.csrf'
  ]
  appModule.factory "UserService", ($http, $q, CSRF, $rootScope, MessageService) ->
    #----------------------------------------------------------------------private variables
    users = null

    #----------------------------------------------------------------------public variables
    service = {}
    service.currentUser = null

    #----------------------------------------------------------------------public functions
    service.listUsers = ()->
      if users
        return users
      else
        $http.get("#{config.baseUrl}/user/all")
        .then (result) ->
          users = result.data
        .catch (err)->
          handleErrorMsg(err)

    service.createUser = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        newUser =
          name: user.name
          email:user.email
          password: user.password
          _csrf: data._csrf
        $http.put("#{config.baseUrl}/user/create", newUser)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.getUserDetail = (user)->
      deferred = $q.defer()
      deferred.resolve user if angular.equals user, service.currentUser
      $http.get("#{config.baseUrl}/user/specifics/#{user.id}")
      .then (result) ->
        service.currentUser = result.data
        deferred.resolve result.data
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.updateUser = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        editingUser =
          id: user.id
          name: user.name
          email:user.email
          password: user.password
          _csrf: data._csrf
        $http.put("#{config.baseUrl}/user/update", editingUser)
        .then (result) ->
          service.currentUser = result.data
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
        deferred.promise

    service.destroyUser = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        deletingUser =
          id: user.id
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/user/destroy", deletingUser)
        .then (result) ->
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

  #-------------------------------------------------------------------handlers
    handleErrorMsg = (err)->
      msg = ""
      if err.data?.errors?
        for error in err.data.errors
          if typeof error is 'string'
            msg += MessageService.handleDataErrorMsg(error)
          if error.ValidationError?.email?
            msg += MessageService.handleValidationErrorMsg(error.ValidationError.email)
          if error.ValidationError?.name?
            msg += MessageService.handleValidationErrorMsg(error.ValidationError.name)
          if error.ValidationError?.password?
            msg += MessageService.handleValidationErrorMsg(error.ValidationError.password)
          unless msg then msg = "Internal Server Error, please try again"
      errData =
        msg: msg
        type: "error"
      console.log "error msg", errData
      $rootScope.$broadcast("ERR_MSG", errData)
      return

  #-----------------------------------------------------------------------return object
    service
