define [
  'app/states/user/user-module'
  'app/states/user/user-service'
  'app/states/user/list/list-ctrl'
  'app/states/user/edit/edit-ctrl'
  'app/states/user/details/details-ctrl'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, $state) ->

    init = ->

    #-------------------------------------------------------------------- init()
    init()



