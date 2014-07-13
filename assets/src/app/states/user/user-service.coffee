define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config) ->
  appModule = angular.module 'app.states.user.service', []
  appModule.factory "UserService", ($http, $q) ->
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
        $http.get("#{config.baseUrl}/user/list").then (result) -> users = result.data

    service.getUser = (id)->
      if user?.id is id
        return user
      else
        $http.get("#{config.baseUrl}/user/detail/#{{id}}").then (result) -> user = result.data
    #-----------------------------------------------------------------------return object
    service
