define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.home', [
    'ui.router'
    'templates'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "home",
      templateUrl: "app/states/home/home"
      url: "/"
      controller:"HomeCtrl"
      resolve:
        UsersData: ($q, UserService) ->
          deferred = $q.defer()
          UserService.listUsers()
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve null
          deferred.promise
        SailsSocketIO: ($q, SailsSocket) ->
          deferred = $q.defer()
          SailsSocket.init()
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve null
          deferred.promise