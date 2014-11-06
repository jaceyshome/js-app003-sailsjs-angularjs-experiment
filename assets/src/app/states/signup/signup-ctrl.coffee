define [
  'app/states/signup/signup-module'
], ->
  module = angular.module 'app.states.signup'
  module.controller 'SignupCtrl', ($scope, $state, UserService, Validation, MessageService) ->
    $scope.user = []

    init = ->
      $scope.formTitle = "Sign up"
      $scope.submitBtnText = "Save"
      $scope.attributes = Validation.getModelAttributes('user',
        ['name', 'email', 'password', 'confirmPassword'])

    $scope.sumbit = ()->
      result = Validation.validate(
        values:$scope.user
        attributes: $scope.attributes
      )
      if result
        MessageService.showError(result.message)
        return
      UserService.createUser($scope.user)
      .then (result)->
        if result
          UserService.setUser result
          $state.go 'home'
      .catch (err)->
        MessageService.handleServerDefaultError()

    init()
