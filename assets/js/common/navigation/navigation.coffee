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
      $scope.dropDownSettings = {data: null}
      $scope.newProjectSettings = {
        data: {name:''}
        visible: false
      }

      init = ->
        ProjectService.listProjects().then((results)->
          $scope.projects = results
        )

      handleCreatingProjectAfter = (project)->
        goToProject(project)

      reset = ()->
        $scope.dropDownSettings = {data: null}
        $scope.newProjectSettings = {
          data: {name:''}
          visible: false
        }

      goToProject = (project)->
        reset()
        $state.go 'project.details', {id:project.id, shortLink:project.shortLink}
        return

        #------------------------ $scope functions -------------------------
      $scope.toggleProjectsList = (e)->
        return unless $scope.projects
        if $scope.dropDownSettings.data is $scope.projects
          $scope.dropDownSettings.data = null
        else
          $scope.dropDownSettings.data = $scope.projects
        $scope.dropDownSettings.visible = ($scope.dropdownItems isnt null)

      $scope.selectItem = goToProject

      $scope.toggleNewProjectPanel = (e)->
        $scope.newProjectSettings.visible = !$scope.newProjectSettings.visible

      $scope.createProject = ()->
        ProjectService.createProject($scope.newProjectSettings.data).then (result)->
          if result
            handleCreatingProjectAfter(result)

      $scope.logout = ->
        CSRF.get().then (data)->
          $http.post("#{config.baseUrl}/session/destroy", {_csrf:data._csrf})
          .then (result) ->
            $state.go("login")
          .catch (err)->
            console.log "log out fail"

      #--------------------------- init() ---------------------------------
      init()
