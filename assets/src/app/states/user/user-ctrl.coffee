define [
  'app/states/user/user-module'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope) ->
    console.log "user ctrl"
