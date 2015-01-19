define [
  'angular'
], ->
  module = angular.module 'app.states.project.details.projectstages', []
  module.directive 'projectStages', (StageService, ProjectService, TaskService, Constants, AppService) ->
    restrict: "A"
    scope: {
      settings: "="
    }
    templateUrl: "app/states/project/details/projectstages/projectstages"
    link: ($scope, $element, $attrs) ->
      $scope.editingStage = null
      $scope.newTask = {name: ""}
      $scope.options =
        accept: (sourceNode, destNodes, destIndex) ->
          return destNodes.$element.attr("type") is 'stage'
        dropped: (event) ->
          source = event.source
          dest = event.dest
          if source.index isnt dest.index
            stage = source.nodeScope.$modelValue
            AppService.updatePos(stage,dest.nodesScope.$modelValue)
            StageService.updateStage(stage)
            return
        beforeDrop: (event) ->
          unless event.dest.nodesScope.$element.attr("type") is 'stage'
            event.source.nodeScope.$$apply = false
          return

      init = ()->
        $scope.settings = {} unless $scope.settings
        $scope.settings.editingKey = null

      reset = ()->
        $scope.settings.editingKey = null
        resetEditingStage()
        resetNewTask()

      resetEditingStage = ()->
        $scope.editingStage = null

      resetNewTask = ()->
        $scope.newTask = {name: ""}

      #------------------------ Scope functions -------------------------
      $scope.editStage = (stage)->
        reset()
        $scope.editingStage = angular.copy(stage)

      $scope.removeStage = (stage)->
        StageService.destroyStage(stage)

      $scope.saveEditingStage = (stage)->
        return unless $scope.editingStage.name
        return unless $scope.editingStage?.id is stage?.id
        StageService.updateStage($scope.editingStage).then(resetEditingStage)

      $scope.resetEditingStage = resetEditingStage

      $scope.showNewTaskFieldToStage = (stage)->
        reset()
        $scope.settings.editingKey = "#{stage.id}_task"

      $scope.addTaskToStage = (stage)->
        return unless $scope.newTask.name?.length > 0
        data = angular.copy($scope.newTask)
        data.idStage = stage.id
        data.idProject = stage.idProject
        TaskService.createTask(data).then(resetNewTask)

      init()