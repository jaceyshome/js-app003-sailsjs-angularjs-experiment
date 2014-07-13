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
    user = null

    #----------------------------------------------------------------------public variables
    service = {}

    #----------------------------------------------------------------------public functions
    service.listUsers = ()->
      if users
        return users
      else
        $http.get("#{config.baseUrl}/user/all").then (result) -> users = result.data

    service.getUser = (id)->
      if user?.id is id
        return user
      else
        $http.get("#{config.baseUrl}/user/detail/#{{id}}").then (result) -> user = result.data
    #-----------------------------------------------------------------------return object
    service
