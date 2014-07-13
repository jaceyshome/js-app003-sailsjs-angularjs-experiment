define [
  'angular'
  'angular_ui_router'
  'templates'
  'common/fieldmatch/fieldmatch'
], ->
  module = angular.module 'app.states.user', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'common.fieldmatch.directive'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user",
      templateUrl: "app/states/user/list/list"
      url: "/user"
      controller: "UserCtrl"
      resolve:
        UsersData: ($q, UserService) ->
          deferred = $q.defer()
          UserService.listUsers()
          .then (result)->
              deferred.resolve result
          .catch ->
              deferred.resolve undefined
          deferred.promise