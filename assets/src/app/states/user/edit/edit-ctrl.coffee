define [
  'app/states/user/edit/edit-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user.edit'
  module.controller 'UserEditCtrl', ($scope, $state, UserData, UserService) ->
    #------------------------------------------------------------public functions
    $scope.user = angular.copy UserData

    #------------------------------------------------------------private functions
    init = ->
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
    #-------------------------------------------------------------scope functions
    $scope.handleSumbit = ->
      return unless validateForm($scope.user)
      data =
        name: user.name
        email: user.email
        password: user.password
      UserService.udpateUser(data)

    #-------------------------------------------------------------------- init()
    init()



