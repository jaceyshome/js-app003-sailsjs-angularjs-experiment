define [
  'angular'
  'app/states/user/detail/detail-module'
  'app/states/user/detail/detail-service'
], ->
  module = angular.module 'app.states.user.detail'
  module.controller 'UserDetailCtrl', ($scope) ->

    #-------------------------------------------------------------private variables

    #-------------------------------------------------------------scope variables

    #-------------------------------------------------------------private functions

  init = ()->
    console.log "user detail page"
  #------------------------------------------------------------public functions

  #-----------------------------------------------------------------------init()
  init() 