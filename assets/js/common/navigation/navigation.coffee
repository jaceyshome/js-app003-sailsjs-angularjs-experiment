define [
  'angular'
  'angular_resource'
  'app/config'
],(angular, angular_resource, config)->
  module = angular.module 'common.navigation', [
    'common.csrf'
  ]
  module.directive 'tntNavigation', ($http, $state, CSRF, Utility, ProjectService)->
    restrict:"A"
    scope:{}
    templateUrl: "common/navigation/navigation"
    link:($scope, element, attrs) ->
      $scope.projects = null
      $scope.dropDownItems = false

      init = ->
        ProjectService.listProjects().then((results)->
          $scope.projects = results
        )

      #------------------------ $scope functions -------------------------
      $scope.toggleProjectsList = (e)->
        return unless $scope.projects
        if $scope.dropdownItems is $scope.projects
          $scope.dropdownItems = null
        else
          $scope.dropdownItems = $scope.projects

      $scope.logout = ->
        CSRF.get().then (data)->
          $http.post("#{config.baseUrl}/session/destroy", {_csrf:data._csrf})
          .then (result) ->
            $state.go("login")
          .catch (err)->
            console.log "log out fail"

      #--------------------------- init() ---------------------------------
      init()
