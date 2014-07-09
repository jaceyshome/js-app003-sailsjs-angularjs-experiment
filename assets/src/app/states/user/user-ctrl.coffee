define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, UserCreate, CSRF) ->
    $scope.user = []

    init = ->
      console.log "user controller"

    $scope.createUser = (user)->
      data =
        name: user.name
        email: user.email
        encryptedPassword: user.encryptedPassword
        confirmation: user.confirmation

      CSRF.get((result)->
        data._csrf = result._csrf
        UserCreate.save(data, (result)->
          console.log "success", result
        )
      )



