define [
  'angular'
], ->
  module = angular.module 'app.states.project.details.projectstages', []
  module.directive 'projectStages', (StageService, ProjectService, Constants) ->
    restrict: "A"
    scope: {
      settings: "="
    }
    templateUrl: "app/states/project/details/projectstages/projectstages"
    link: ($scope, $element, $attrs) ->
      $scope.options =
        accept: (sourceNode, destNodes, destIndex) ->
          data = sourceNode.$modelValue
          destType = destNodes.$element.attr("type")
          data.type is destType # only accept the same type

        dropped: (event) ->
          source = event.source
          dest = event.dest
          if source.index isnt dest.index
            updateStagePos(source.nodeScope.$modelValue,dest.nodesScope.$modelValue)
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

      updateStagePos = (stage,stages)->
        index = stages.indexOf stage
        _stags = angular.copy stages
        if (index + 1) is stages.length
          stage.pos = (_stags[index-1].pos + Constants.POS_STEP)
        else if index is 0
          stage.pos = (_stags[index+1].pos - Constants.POS_STEP)
        else
          stage.pos = (_stags[index-1].pos + (_stags[index+1].pos - _stags[index-1].pos) / 2)
        StageService.updateStage(stage)

      init = () ->
        undefined

      #------------------------ Scope functions -------------------------

      #------------------------ init ------------------------------------
      init()
      