define [
  'angular'
], ->
  module = angular.module 'app.states.project.details.projectstages', []
  module.directive 'projectStages', (StageService, ProjectService, Constants, AppService) ->
    restrict: "A"
    scope: {
      settings: "="
    }
    templateUrl: "app/states/project/details/projectstages/projectstages"
    link: ($scope, $element, $attrs) ->
      $scope.editingStage = null
      $scope.options =
        accept: (sourceNode, destNodes, destIndex) ->
          data = sourceNode.$modelValue
          destType = destNodes.$element.attr("type")
          data.type is destType # only accept the same type

        dropped: (event) ->
          source = event.source
          dest = event.dest
          if source.index isnt dest.index
            stage = source.nodeScope.$modelValue
            AppService.updatePos(stage,dest.nodesScope.$modelValue)
            StageService.updateStage(stage)
          # update changes to server
#          if destNode.isParent(sourceNode) and destNode.$element.attr("type") is "stage" # If it moves in the same group, then only update group
#            group = destNode.$nodeScope.$modelValue
#            group.save()
#          else # save all
##            $scope.saveGroups()
#          return
        beforeDrop: (event) ->
#          event.source.nodeScope.$$apply = false  unless window.confirm("Are you sure you want to drop it here?")
          return

      init = () ->
        undefined

      cancelEditingStage = ()->
        $scope.editingStage = null

      #------------------------ Scope functions -------------------------
      $scope.editStage = (stage)->
        $scope.editingStage = angular.copy(stage)

      $scope.saveEditingStage = (stage)->
        #TODO validation
        return unless $scope.editingStage?.id is stage?.id
        StageService.updateStage($scope.editingStage).then(cancelEditingStage).catch(cancelEditingStage)

      $scope.cancelEditingStage = cancelEditingStage


      #------------------------ init ------------------------------------
      init()
      