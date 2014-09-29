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

    #-------------------------------------------------------------private functions
    init = ->
      $scope.formTitle = "Sign up"
      $scope.submitBtnText = "Save"
      $scope.attributes = ValidationService.getModelAttributes(
        'user',
        ['name', 'email', 'password', 'confirmPassword'])

    #-----------------------------------------------------public functions
    $scope.sumbit = ()->
      msg = ValidationService.validate(
        values:$scope.user
        attributes: $scope.attributes
      )
      return if msg
      UserService.createUser($scope.user)
      .then (result)->
        if result
          UserService.currentUser = result
          $state.go 'user.details', {id:result.id}
      .catch (err)->
        handleError(err)

    #------------------------------------------------------ event handlers
    handleError = (err)->
      $scope.$emit('$noticeboard.error', {msg:err})

    #-----------------------------------------------------------------------init()
    init()