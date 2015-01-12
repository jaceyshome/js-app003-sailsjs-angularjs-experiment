define [
  'angular'
  'app/states/project/details/details-module'
], ->
  module = angular.module 'app.states.project.details'
  module.controller 'ProjectDetailsCtrl', ($scope, $state, Project, ProjectService, StageService) ->
    $scope.project = Project
    $scope.editProject = angular.copy Project
    $scope.newStage =
      idProject: Project.id
      name: ""
    $scope.settings =
      editKey: null

    init = ->

    handleUpdatingProjectAfter = (result)->
      $scope.editProject = angular.copy result
      reset()

    reset = ()->
      $scope.settings =
        editKey: null

    #----------------------------- $scope functions -----------------------
    $scope.save = ()->
      ProjectService.updateProject($scope.editProject).then((result)->
        if result then handleUpdatingProjectAfter(result)
      ).catch(()->
        console.log "Server Error"
      )

    $scope.cancelEditing = (key)->
      $scope.editProject[key] = $scope.project[key]
      reset()

    $scope.addStage = ()->
      $scope.project.stages = [] unless $scope.project.stages
      StageService.createStage($scope.newStage).then ()->
        reset()
        $scope.newStage =
          idProject: Project.id
          name: ""

    $scope.remove = (scope)->
      console.log "removeNode", scope
      scope.remove()

    $scope.toggle = (scope)->
      scope.toggle()

    $scope.newTask = (scope)->
      nodeData = scope.$modelValue
      console.log "node Data", nodeData
      nodeData.tasks.push({
        name: 'new item'
        tasks: []
      })

    #----------------------------- init() ---------------------------------
    init()
