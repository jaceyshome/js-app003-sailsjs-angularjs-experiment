define [
  'app/states/signup/signup-module'
], ->
  module = angular.module 'app.states.signup'
  module.controller 'SignupCtrl', [
    '$scope','$state','UserService','ValidationService','MessageService', (
      $scope, $state, UserService, ValidationService, MessageService
    ) ->
      $scope.user = []

      init = ->
        $scope.formTitle = "Sign up"
        $scope.submitBtnText = "Save"
        $scope.attributes = ValidationService.getModelAttributes(
          'user',
          ['name', 'email', 'password', 'confirmPassword'])

      $scope.sumbit = ()->
        message = ValidationService.validate(
          values:$scope.user
          attributes: $scope.attributes
        )
        if message
          MessageService.showError(message)
          return
        UserService.createUser($scope.user)
        .then (result)->
          if result
            UserService.currentUser = result
            $state.go 'home'
        .catch (err)->
          MessageService.handleServerDefaultError()

      init()
  ]