define [
  'app/states/signup/signup-module'
  'app/states/signup/signup-service'
], ->
  module = angular.module 'app.states.signup'
  module.controller 'SignupCtrl', ($scope, SignupService, CSRF, Utility) ->
    #-------------------------------------------------------------scope variables
    $scope.user = []

    #-------------------------------------------------------------private functions
    init = ->
      console.log "signupCtrl"

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
      return unless validateForm($scope.user)
      data =
        name: user.name
        email: user.email
        password: user.password
      CSRF.get((result)->
        data._csrf = result._csrf
        SignupService.save(data, (result)->
          console.log "success", result
        , (err)->
          Utility.handleServerError(err)
        )
      )


    #-----------------------------------------------------------------------init()
    init()