define [
  'app/states/signup/signup-module'
], ->
  module = angular.module 'app.states.signup'
  module.controller 'SignupCtrl', (
    $scope,
    $state,
    UserService,
    ValidationService
  ) ->
    #-------------------------------------------------------------scope variables
    $scope.user = []
    $scope.attributes = ValidationService.getModelAttributes(
      'user',
      ['password', 'confirmPassword', 'email', 'name'])
    console.log "$scope.attributes", $scope.attributes

    #-------------------------------------------------------------private functions
    init = ->
      $scope.formTitle = "Sign up"
      $scope.submitBtnText = "Save"

    validateForm = (user)->
      msg = ''
      msg += 'name is required' unless user.name
      msg += 'password is required' unless user.password
      if user.password? isnt user.confirmPassword?
        msg += 'confirm password does not match password'
      if msg then alert msg
      return !msg
    #------------------------------------------------------------public functions
    $scope.handleSumbit = ()->
#      return unless validateForm($scope.user)
      msg = ValidationService.validate(
        values:$scope.user
        attributes: $scope.attributes
      )
      if msg
        alert msg
        return
      return
      UserService.createUser($scope.user)
      .then (result)->
        if result
          UserService.currentUser = result
          $state.go 'user.details', {id:result.id}

      .catch (err)->
        console.log "server error", err

    #-----------------------------------------------------------------------init()
    init()