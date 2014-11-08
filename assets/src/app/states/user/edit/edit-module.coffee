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
      url: "/edit/:shortLink"
      views:
        'userChildView@user':
          templateUrl: "app/states/user/form/form"
          controller: "UserEditCtrl"
      resolve:
        UserData: ($q, $stateParams, UserService) ->
          deferred = $q.defer()
          unless $stateParams.shortLink
            UserService.goToDefault()
            deferred.resolve undefined
          UserService.getUserDetail({shortLink:$stateParams.shortLink})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise