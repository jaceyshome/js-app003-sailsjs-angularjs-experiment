define [
  'app/states/signup/signup-module'
], ->
  module = angular.module 'app.states.signup'
  module.controller 'SignupCtrl', ($scope, $state, UserService, Validation, MessageService) ->
    $scope.user = []

    init = ->
      $scope.formTitle = "Sign up"
      $scope.submitBtnText = "Save"
      $scope.attributes = Validation.getModelAttributes('User',
        ['name', 'email', 'password'])
      $scope.attributes.confirmPassword =
        type: "string"
        required: true
        maxLength: 45
        match: "password"

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
