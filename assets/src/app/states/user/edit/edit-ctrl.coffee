define [
  'app/states/user/edit/edit-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user.edit'
  module.controller 'UserEditCtrl', ($scope, $state, UserData, UserService, SailsSocket) ->
    $scope.user = angular.copy UserData
    $scope.formTitle = "Edit User"
    $scope.submitBtnText = "Save"
    $scope.sumbit = ->
      UserService.updateUser($scope.user)

