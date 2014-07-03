define [
  'angular'
  ], ->
  module = angular.module 'common.mediaslider', ['templates']
  module.directive 'tntMediaSlider', () ->
    restrict:"A"
    scope:{
      currentTime:"="
      duration:"="
      bufferedPercent:"="
      seek:"="
    }
    templateUrl: "common/mediaslider/main"
    link:($scope, element, attrs) ->
      #console.log "new media slider"
      updateBars = ->
        $scope.playDisplayPercent = 0
        $scope.bufferDisplayPercent = 0
        if $scope.currentTime? and $scope.duration?
          $scope.playDisplayPercent = 100*$scope.currentTime/$scope.duration
          #console.log "$scope.bufferPercent", $scope.bufferedPercent
          $scope.bufferDisplayPercent = (100*$scope.bufferedPercent)-$scope.playDisplayPercent


      $scope.$watch "currentTime", (val) ->
        #console.log "currentTime", val
        $scope.currentTime = val
        updateBars()

      $scope.$watch "duration", (val) ->
        #console.log "duration", val
        $scope.duration = val
        updateBars()

      $scope.$watch "bufferedPercent", (val) ->
        #console.log "bufferedPercent", val
        #$scope.bufferPercent = val*100
        updateBars()

      element.click (e)->
        position = e.pageX-element.offset().left
        time = $scope.duration * position/element.outerWidth()
        $scope.seek? time

      updateBars()
