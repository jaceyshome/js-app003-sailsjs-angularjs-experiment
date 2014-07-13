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

    #------------------------------------------------------------public functions
    $scope.edit = ->
      $state.go("user.edit", {id: $scope.user.id} )

    #-----------------------------------------------------------------------init()
    init()