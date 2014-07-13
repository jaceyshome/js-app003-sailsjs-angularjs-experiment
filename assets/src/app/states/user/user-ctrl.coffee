define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, CSRF, Utility, UsersData) ->
    $scope.users = UsersData

    init = ->
      console.log "users", $scope.users



    #-------------------------------------------------------------------- init()
    init()



