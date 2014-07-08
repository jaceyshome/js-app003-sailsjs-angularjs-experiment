define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, User) ->
    console.log "user ctrl"

    $scope.createUser = ->
      data =
        name: 'stacey'
        email: 'stacey@gmail.com'
        encryptedPassword: 'asdasd21321'

      User.save(data, (result)->
        console.log "success"
      )
