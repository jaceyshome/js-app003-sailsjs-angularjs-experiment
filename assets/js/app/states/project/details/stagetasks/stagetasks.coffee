define [
  'angular'
], ->
  module = angular.module 'app.states.project.details.stagetasks', []
  module.directive 'stageTasks', (StageService, ProjectService, TaskService, Constants, AppService) ->
    restrict: "A"
    scope: {
      stage: "="
    }
    templateUrl: "app/states/project/details/stagetasks/stagetasks"
    link: ($scope, $element, $attrs) ->
      $scope.editingTask = {name: ""}
      $scope.options =
        accept: (sourceNode, destNodes, destIndex) ->
          return destNodes.$element.attr("type") is 'task'
        dropped: (event) ->
          source = event.source
          dest = event.dest
          if source.index isnt dest.index
            task = source.nodeScope.$modelValue
            AppService.updatePos(task,dest.nodesScope.$modelValue)
            TaskService.updateTask(task)
            return
        beforeDrop: (event) ->
          unless event.dest.nodesScope.$element.attr("type") is 'task'
            event.source.nodeScope.$$apply = false
          return

      init = () ->
        $scope.editingTask = {name: ""}

      reset = ()->
        resetEditingTask()

      resetEditingTask = ()->
        $scope.editingTask = {name: ""}

      #------------------------ Scope functions -------------------------
      $scope.saveEditingTask = (task)->
        return unless $scope.editingTask.name
        return unless $scope.editingTask?.id is task?.id
        TaskService.updateTask($scope.editingTask).then(resetEditingTask)

      $scope.editTask = (task)->
        reset()
        $scope.editingTask = angular.copy(task)

      $scope.removeTask = (task)->
        TaskService.destroyTask(task)

      $scope.resetEditingTask = resetEditingTask

      #------------------------ init ------------------------------------
      init()
      