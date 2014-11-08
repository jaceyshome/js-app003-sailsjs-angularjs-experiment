define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.user.service', [
    'common.csrf'
  ]
  appModule.factory "UserService", ($http, $q, CSRF, $rootScope, MessageService, $state, SailsSocket) ->
    #----------------------------------------------------------------------private variables
    _users = null
    _user = null

    #----------------------------------------------------------------------public variables
    service = {}

    #----------------------------------------------------------------------public functions
    service.goToDefault = ()->
      $state.go '/'

    service.getUser = ()->
      _user

    service.setUser = (user)->
      _user = user

    service.listUsers = ()->
      deferred = $q.defer()
      if _users
        deferred.resolve _users
      else
        $http.get("#{config.baseUrl}/user/all")
        .then (result) ->
          _users = result.data
          deferred.resolve result.data
        .catch (err)->
          deferred.resolve null
          handleErrorMsg(err)
      deferred.promise

    service.createUser = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        newUser =
          name: user.name
          email:user.email
          password: user.password
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/user/create", newUser)
        .then (result) ->
          SailsSocket.io.put('/user/create' + result.data.id, result.data)
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.getUserDetail = (user)->
      deferred = $q.defer()
      deferred.resolve user if angular.equals user, _user
      $http.get("#{config.baseUrl}/user/specifics/#{user.shortLink}")
      .then (result) ->
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
          shortLink: user.shortLink
          name: user.name
          email:user.email
          password: user.password
          _csrf: data._csrf
        $http.put("#{config.baseUrl}/user/update", editingUser)
        .then (result) ->
          SailsSocket.io.put('/user/update' + result.data.id, result.data)
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
          shortLink: user.shortLink
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/user/destroy", deletingUser)
        .then (result) ->
          SailsSocket.io.put('/user/destroy' + user.id, user)
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

  #-------------------------------------------------------------------handlers
    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
