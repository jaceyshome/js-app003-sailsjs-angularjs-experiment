define [
  'angular'
  'angular_ui_router'
  'templates'
  'common/fieldmatch/fieldmatch'
], ->
  module = angular.module 'app.states.user.list', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'common.fieldmatch.directive'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user.list",
      templateUrl: "app/states/user/list/list"
      url: "/list"
      controller: "UserListCtrl"
      resolve:
        UsersData: ($q, UserService) ->
          deferred = $q.defer()
          UserService.listUsers()
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise