define [
  'app/states/user/edit/edit-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user.edit'
  module.controller 'UserEditCtrl', ($scope, $state, UserData, UserService) ->
    $scope.user = angular.copy UserData

    init = ->
      $state.go "login" unless UserData
      $scope.formTitle = "Edit User"
      $scope.submitBtnText = "Save"

    validateForm = (user)->
      msg = ''
      msg += 'name is required' unless user.name
      msg += 'password is required' unless user.password
      if user.password? isnt user.confirmPassword?
        msg += 'confirm password does not match password'
      if msg then alert msg
      return !msg

    $scope.sumbit = ->
      return unless validateForm($scope.user)
      UserService.updateUser($scope.user)

    init()



