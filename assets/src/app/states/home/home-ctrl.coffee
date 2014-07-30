define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocket, UserService) ->
    # -------------------------------------------------------------------------------- $scope Variables
    $scope.users = UsersData

    # -------------------------------------------------------------------------------- Private Variables

    # -------------------------------------------------------------------------------- init
    init = () ->
      registerSocketEventListeners()

    # -------------------------------------------------------------------------------- $scope Functions
    $scope.edit = (user)->
      UserService.updateUser(user)
      undefined

    # -------------------------------------------------------------------------------- Private Functions
    registerSocketEventListeners = ->
      SailsSocket.io.on('message', (msg)->
        console.log "receive msg", msg
      )

    # -------------------------------------------------------------------------------- Handler Functions

    # -------------------------------------------------------------------------------- Helper Functions

    # -------------------------------------------------------------------------------- init()
    init()