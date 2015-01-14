define [
  'angular'
], ->
  module = angular.module 'app.states.project.details.projectstages', []
  module.directive 'projectStages', (StageService, ProjectService) ->
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
          sourceNode = event.source.nodeScope
          destNode = event.dest.nodesScope
          unless sourceNode.stage.order is sourceNode.$index
            console.log "dropped sourceNode", sourceNode
            console.log "dropped destNodes", destNode
          # update changes to server
          if destNode.isParent(sourceNode) and destNode.$element.attr("type") is "stage" # If it moves in the same group, then only update group
            group = destNode.$nodeScope.$modelValue
#            group.save()
          else # save all
#            $scope.saveGroups()
          return

        beforeDrop: (event) ->
#          event.source.nodeScope.$$apply = false  unless window.confirm("Are you sure you want to drop it here?")
          return

      init = () ->
        undefined

      #------------------------ Scope functions -------------------------

      #------------------------ init ------------------------------------
      init()
      