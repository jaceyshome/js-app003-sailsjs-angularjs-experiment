define [
  'app/states/home/home-module'
], ->
  module = angular.module 'app.states.home'
  module.controller 'HomeCtrl', ($scope, UsersData, SailsSocket, UserService, $state) ->
    $scope.users = UsersData

