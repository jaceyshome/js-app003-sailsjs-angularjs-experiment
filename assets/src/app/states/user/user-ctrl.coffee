define [
  'app/states/user/user-module'
  'app/states/user/user-resource'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, CSRF, Utility, UserResource) ->

    init = ->
      console.log "UserCtrl"
      UserResource.list((result)->
        console.log "user list", result
      )

    init()


