define [
  'app/states/user/list/list-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserListCtrl', ($scope, $state, UsersData, UserService) ->
    $scope.users = UsersData
    console.log "ererer", UsersData
    $scope.show = (user)->
      $state.go "user.details", {shortLink: user.shortLink}

    $scope.destroy = (user)->
      UserService.destroyUser(user).then (result)->
        if result
          $scope.users.splice $scope.users.indexOf(user), 1
        else
          console.log "servers error"

    $scope.edit = (user)->
      $state.go "user.edit", {shortLink: user.shortLink}



