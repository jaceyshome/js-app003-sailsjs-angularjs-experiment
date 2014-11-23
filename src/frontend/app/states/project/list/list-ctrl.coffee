define [
  'app/states/project/list/list-module'
  'app/states/project/project-service'
], ->
  module = angular.module 'app.states.project.list'
  module.controller 'ProjectListCtrl', ($scope, $state, Projects, ProjectService) ->
    $scope.projects = Projects

    $scope.show = (project)->
      $state.go "project.details", {shortLink: project.shortLink}

    $scope.destroy = (project)->
      ProjectService.destroyProject(project).then (result)->
        if result
          $scope.projects.splice $scope.projects.indexOf(project), 1
        else
          console.log "servers error"

    $scope.edit = (project)->
      $state.go "project.edit", {shortLink: project.shortLink}
