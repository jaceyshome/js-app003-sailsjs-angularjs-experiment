define [
  'angular'
  'app/states/user/details/details-module'
], ->
  module = angular.module 'app.states.user.details'
  module.controller 'UserDetailsCtrl', ($scope, $state, UserData) ->

    $scope.user = UserData

    $scope.edit = ->
      $state.go "user.edit", {id: UserData.id}

