define [
  'angular'
  'angular_ui_router'
], ->
  module = angular.module 'app.states.user.list', [
    'ui.router'
    'templates'
    'common.csrf'
    'common.utility'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user.list",
      parent: 'user'
      url: "/list"
      views:
        'userChildView@user':
          templateUrl: "app/states/user/list/list"
          controller: "UserListCtrl"
      resolve:
        UsersData: ($q, UserService) ->
          deferred = $q.defer()
          UserService.listUsers()
          .then (result)->
            deferred.resolve result
          .catch ->
            UserService.goToDefault()
            deferred.resolve null
          deferred.promise