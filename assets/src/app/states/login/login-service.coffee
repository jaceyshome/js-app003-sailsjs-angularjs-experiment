define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource,config) ->
  appModule = angular.module 'app.states.login.service', [
    'common.csrf'
  ]
  appModule.factory "LoginService", ($http, $q, CSRF) ->
    #----------------------------------------------------------------------private variables

    #----------------------------------------------------------------------public variables
    service = {}
    #----------------------------------------------------------------------public functions
    service.login = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        loginUser =
          name: user.name
          password: user.password
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/session/create", loginUser)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          deferred.resolve null
      deferred.promise
    #-----------------------------------------------------------------------return object
    service
