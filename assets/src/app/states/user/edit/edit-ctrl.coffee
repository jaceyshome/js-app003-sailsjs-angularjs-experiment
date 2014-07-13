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

    #-------------------------------------------------------------scope functions
    $scope.handleSumbit = ->
      UserService.udpateUser($scope.user)

    #-------------------------------------------------------------------- init()
    init()



