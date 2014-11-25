define [
  'angular'
  'angular_ui_router'
  'templates'
], ->
  module = angular.module 'app.states.user.details', [
    'ui.router'
    'templates'
    'common.utility'
    'app.states.user.service'
  ]

  module.config ($stateProvider)->
    $stateProvider.state "user.details",
      parent: 'user'
      url: "/details/:shortLink"
      views:
        'userChildView@user':
          templateUrl: "app/states/user/details/details"
          controller: "UserDetailsCtrl"
      resolve:
        UserData: ($q, $stateParams, UserService) ->
          deferred = $q.defer()
          unless $stateParams.shortLink
            UserService.goToDefault()
            return deferred.resolve undefined
          UserService.getUserDetail({shortLink:$stateParams.shortLink})
          .then (result)->
            deferred.resolve result
          .catch ->
            deferred.resolve undefined
          deferred.promise