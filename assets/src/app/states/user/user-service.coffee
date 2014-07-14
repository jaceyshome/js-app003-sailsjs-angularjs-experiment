define [
  'angular'
  'angular_resource'
  'app/config'
  'common/csrf/csrf'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.user.service', [
    'common.csrf'
  ]
  appModule.factory "UserService", ($http, $q, CSRF) ->
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
        .then (result) -> users = result.data

    service.getUserDetail = (id)->
      if service.currentUser?.id is id
        return service.currentUser
      else
        $http.get("#{config.baseUrl}/user/specifics/#{id}")
        .then (result) -> service.currentUser = result.data

    service.udpateUser = (user)->
      CSRF.get().then (data)->
        user._csrf = data._csrf
        $http.put("#{config.baseUrl}/user/update", user)
        .then (result) -> service.currentUser = result.data

    service.destroyUser = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        deletingUser =
          id: user.id
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/user/destory", deletingUser)
        .then (result) ->
          return deferred.resolve result.data
        .catch (result)->
          return deferred.resolve null
      deferred.promise

    #-----------------------------------------------------------------------return object
    service
