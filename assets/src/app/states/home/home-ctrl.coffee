define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocket, UserService, $state) ->
    $scope.users = UsersData

    init = () ->
      registerSocketEventListeners()

    $scope.edit = (user)->
      $state.go "user.edit", {id: user.id}

    $scope.show = (user)->
      $state.go "user.details", {id: user.id}

    registerSocketEventListeners = ->
      SailsSocket.io.on('message', (msg)->
        console.log "receive msg", msg
      )

    init()