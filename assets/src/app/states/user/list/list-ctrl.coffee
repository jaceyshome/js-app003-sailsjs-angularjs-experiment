define [
  'app/states/user/list/list-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserListCtrl', ($scope, $state, UsersData, UserService, SailsSocket) ->
    #------------------------------------------------------------public functions
    $scope.users = UsersData

    #------------------------------------------------------------private functions
    init = ->
      $state.go "login" unless UsersData

    #-------------------------------------------------------------scope functions
    $scope.show = (user)->
      $state.go("user.details", {id: user.id} )

    $scope.destroy = (user)->
      UserService.destroyUser(user).then (result)->
        if result
          $scope.users.splice $scope.users.indexOf(user), 1
        else
          console.log "servers error"

    $scope.edit = (user)->
      $state.go("user.edit", {id: user.id} )
    #-------------------------------------------------------------------- init()
    init()



