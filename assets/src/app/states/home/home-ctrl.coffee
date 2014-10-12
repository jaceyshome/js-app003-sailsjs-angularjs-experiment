define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocket, UserService) ->
    $scope.users = UsersData

    init = () ->
      registerSocketEventListeners()

    $scope.edit = (user)->
      UserService.updateUser(user)
      undefined

    registerSocketEventListeners = ->
      SailsSocket.io.on('message', (msg)->
        console.log "receive msg", msg
      )

    init()