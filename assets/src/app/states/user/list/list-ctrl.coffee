define [
  'app/states/user/list/list-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserListCtrl', ($scope, CSRF, Utility, UsersData) ->
    $scope.users = UsersData

    init = ->
      console.log "users", $scope.users



    #-------------------------------------------------------------------- init()
    init()



