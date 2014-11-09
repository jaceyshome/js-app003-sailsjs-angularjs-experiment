define [
  'app/states/user/list/list-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user.list'
  module.controller 'UserListCtrl', ($scope, $state, UsersData, UserService, SailsSocket) ->
    $scope.users = UsersData

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
