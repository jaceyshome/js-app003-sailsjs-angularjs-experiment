define [
  'angular'
  'angular_resource'
  'app/config'
],(angular, angular_resource, config)->
  module = angular.module 'common.navigation', [
    'common.csrf'
  ]
  module.directive 'tntNavigation', ($http, $state, CSRF)->
    restrict:"A"
    scope:{}
    templateUrl: "common/navigation/navigation"
    link:($scope, element, attrs) ->
      $scope.logout = ->
        CSRF.get().then (data)->
          $http.post("#{config.baseUrl}/session/destroy", {_csrf:data._csrf})
          .then (result) ->
            $state.go("login")
          .catch (err)->
            console.log "log out fail"

