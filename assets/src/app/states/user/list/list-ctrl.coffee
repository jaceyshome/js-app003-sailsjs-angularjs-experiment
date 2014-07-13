define [
  'angular'
  'app/states/user/list/list-module'
  'app/states/user/list/list-resource'
], ->
  module = angular.module 'app.states.user.list'
  module.controller 'UserListCtrl', ($scope) ->

    #-------------------------------------------------------------private variables

    #-------------------------------------------------------------scope variables

    #-------------------------------------------------------------private functions

    init = ()->
      undefined
    #------------------------------------------------------------public functions

    #-----------------------------------------------------------------------init()
    init()