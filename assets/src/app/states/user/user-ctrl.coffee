define [
  'app/states/user/user-module'
  'app/states/user/user-service'
], ->
  module = angular.module 'app.states.user'
  module.controller 'UserCtrl', ($scope, UserCreate, CSRF, Utility) ->
    $scope.user = []

    init = ->
      console.log "user controller"

    validateUser = (user)->
      msg = ''
      msg += 'name is required' unless user.name
      msg += 'password is required' unless user.password
      if user.password? isnt user.confirmPassword?
        msg += 'confirm password does not match password'
      if msg then alert msg
      return !msg

    $scope.createUser = (user)->
      return unless validateUser(user)
      data =
        name: user.name
        email: user.email
        password: user.password

      CSRF.get((result)->
        data._csrf = result._csrf
        UserCreate.save(data, (result)->
          console.log "success", result
        , (err)->
          Utility.handleServerError(err)
        )
      )

    init()


