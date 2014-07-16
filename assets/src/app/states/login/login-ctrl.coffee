define [
  'app/states/login/login-module'
  'app/states/login/login-service'
], ->
  module = angular.module 'app.states.login'
  module.controller 'LoginCtrl', ($scope, $state ,LoginService) ->
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
      LoginService.login($scope.user).then (result)->
        if result
          $state.go 'user.details', {id:result.id}
        else
          console.log "server error"

    #-----------------------------------------------------------------------init()
    init()