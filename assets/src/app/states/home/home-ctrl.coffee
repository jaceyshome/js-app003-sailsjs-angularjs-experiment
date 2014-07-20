define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocketIO) ->
    # -------------------------------------------------------------------------------- $scope Variables

    # -------------------------------------------------------------------------------- Private Variables

    # -------------------------------------------------------------------------------- init
    init = () ->
      console.log "hello HomeCtrl"
      $scope.users = UsersData

    # -------------------------------------------------------------------------------- $scope Functions
    $scope.edit = (user)->
      console.log "edit user", user
      SailsSocketIO.put('/user/update' + user.id, user)

    $scope.$on 'sailsSocket:message', (ev, data)->
      console.log "data!!!!!!!!!!", data

    SailsSocketIO.get('/user/subscribe')

    SailsSocketIO.on('message', (msg)->
      console.log "receive msg", msg
    )

    # -------------------------------------------------------------------------------- Private Functions

    # -------------------------------------------------------------------------------- Handler Functions

    # -------------------------------------------------------------------------------- Helper Functions

    # -------------------------------------------------------------------------------- init()
    init()