define [
  'app/states/user/list/list-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserListCtrl', ($scope, $state, CSRF, Utility, UsersData, UserService) ->
    #------------------------------------------------------------public functions
    $scope.users = UsersData

    #------------------------------------------------------------private functions
    init = ->


    #-------------------------------------------------------------scope functions
    $scope.showUser = (user)->
      $state.go("user.details", {id: user.id} )

    #-------------------------------------------------------------------- init()
    init()



