define [
  'app/states/user/user-module'
  'app/states/user/user-resource'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, CSRF, Utility) ->

    init = ->
      console.log "UserCtrl"

    init()


