define [
  'angular'
  'app/states/project/details/details-module'
], ->
  module = angular.module 'app.states.project.details'
  module.controller 'ProjectDetailsCtrl', ($scope, $state, Project, ProjectService) ->
    $scope.project = angular.copy Project #a copy of the project
    $scope.settings =
      editDescription: false

    init = ->


    handleUpdatingProjectAfter = (result)->
      $scope.project = angular.copy result
      reset()

    reset = ()->
      $scope.settings =
        editDescription: false

    #----------------------------- $scope functions -----------------------
    $scope.save = ()->
      ProjectService.updateProject($scope.project).then((result)->
        if result then handleUpdatingProjectAfter(result)
      ).catch(()->
        console.log "Server Error"
      )



    #----------------------------- init() ---------------------------------
    init()
