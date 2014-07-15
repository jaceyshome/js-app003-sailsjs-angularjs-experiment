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
      url: "/details/{id:[0-9]+}"
      views:
        'userChildView@user':
          templateUrl: "app/states/user/details/details"
          controller: "UserDetailsCtrl"
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