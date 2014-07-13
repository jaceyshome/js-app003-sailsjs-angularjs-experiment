define [
  'angular'
  'app/states/user/details/details-module'
], ->
  module = angular.module 'app.states.user.details'
  module.controller 'UserDetailsCtrl', ($scope, $state, UserData) ->
    #-------------------------------------------------------------private variables

    #-------------------------------------------------------------scope variables

    #-------------------------------------------------------------private functions

    init = ()->
      $state.go('user') unless UserData
      $scope.user = UserData
      console.log "user detail page", UserData

    #------------------------------------------------------------public functions

    #-----------------------------------------------------------------------init()
    init()