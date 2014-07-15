define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.signin.service', [
    'common.csrf'
  ]
  appModule.factory "SigninService", ($http, $q, CSRF) ->
    #----------------------------------------------------------------------private variables

    #----------------------------------------------------------------------public variables
    service = {}
    #----------------------------------------------------------------------public functions
    service.signin = (user)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        signinUser =
          name: user.name
          password: user.password
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/session/create", signinUser)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          deferred.resolve null
      deferred.promise
    #-----------------------------------------------------------------------return object
    service
