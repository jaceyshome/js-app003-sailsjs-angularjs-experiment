define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, $state) ->

    init = ->
      $state.go('user.list')


    #-------------------------------------------------------------------- init()
    init()



