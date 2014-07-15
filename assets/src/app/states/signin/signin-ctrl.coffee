define [
  'app/states/signin/signin-module'
  'app/states/signin/signin-service'
], ->
  module = angular.module 'app.states.signin'
  module.controller 'SigninCtrl', ($scope, $state ,SigninService) ->
    #-------------------------------------------------------------scope variables
    $scope.user = []

    #-------------------------------------------------------------private functions
    init = ->

    validateForm = (user)->
      msg = ''
      msg += 'name is required' unless user.name
      msg += 'password is required' unless user.password
      if msg then alert msg
      return !msg
    #------------------------------------------------------------public functions
    $scope.handleSumbit = ()->
      return unless validateForm($scope.user)
      SigninService.signin($scope.user).then (result)->
        if result
          $state.go 'user.details', {id:result.id}
        else
          console.log "server error"

    #-----------------------------------------------------------------------init()
    init()