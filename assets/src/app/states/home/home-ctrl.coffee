define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocketIO) ->
    # -------------------------------------------------------------------------------- $scope Variables
    $scope.users = UsersData

    # -------------------------------------------------------------------------------- Private Variables

    # -------------------------------------------------------------------------------- init
    init = () ->
      registerSocketEventListeners()

    # -------------------------------------------------------------------------------- $scope Functions
    $scope.edit = (user)->
      undefined

    # -------------------------------------------------------------------------------- Private Functions
    registerSocketEventListeners = ->
      #angular way
      #$scope.$on 'sailsSocket:message', (ev, data)->
      SailsSocketIO.on('message', (msg)->
        console.log "receive msg", msg
      )

    # -------------------------------------------------------------------------------- Handler Functions

    # -------------------------------------------------------------------------------- Helper Functions

    # -------------------------------------------------------------------------------- init()
    init()