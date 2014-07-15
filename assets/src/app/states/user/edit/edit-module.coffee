define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.user.edit', [
    'ui.router'
    'templates'
    'common.utility'
    'common.fieldmatch.directive'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user.edit",
      parent: 'user'
      url: "/edit/{id:[0-9]+}"
      views:
        'userChildView@user':
          templateUrl: "app/states/user/form/form"
          controller: "UserEditCtrl"
      resolve:
        UserData: ($q, $stateParams, UserService) ->
          deferred = $q.defer()
          if UserService.currentUser?.id is $stateParams.id
            deferred.resolve UserService.currentUser
            return
          UserService.getUserDetail({id:$stateParams.id})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise