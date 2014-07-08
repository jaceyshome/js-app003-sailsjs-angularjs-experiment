define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, UserCreate) ->
    $scope.user = []

    init = ->
      console.log "user controller"

    $scope.createUser = (user)->
      data =
        name: user.name
        email: user.email
        encryptedPassword: user.encryptedPassword
      #      data =
#        name: 'stacey1'
#        email: 'stacey1@gmail.com'
#        encryptedPassword: 'asdasd21321'

      UserCreate.save(data, (result)->
        console.log "success", result
      )
