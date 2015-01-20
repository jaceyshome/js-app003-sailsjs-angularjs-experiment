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
            data =
              id: task.id
              pos: task.pos
            TaskService.updateTask(data)
            return
        beforeDrop: (event) ->
#          destNodes.$element.attr("data-stage-id")
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

      $scope.editTask = (task, key)->
        reset()
        $scope.editingTask = {id: task.id }
        $scope.editingTask[key] = task[key]

      $scope.destroyTask = (task)->
        TaskService.destroyTask(task)

      $scope.resetEditingTask = resetEditingTask


      #------------------------ init ------------------------------------
      init()
      