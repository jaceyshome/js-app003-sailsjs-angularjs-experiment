define [
  'angular'
  'app/states/user/detail/detail-ctrl'
  'app/states/user/detail/detail-module'
  'app/states/user/detail/detail-resource'
], ->
  module = angular.module 'app.states.user.detail'
  module.controller 'UserDetailCtrl', ($scope, UserDetailResource) ->

    #-------------------------------------------------------------private variables

    #-------------------------------------------------------------scope variables

    #-------------------------------------------------------------private functions

    init = ()->
      console.log "user detail page"

    #------------------------------------------------------------public functions

    #-----------------------------------------------------------------------init()
    init()