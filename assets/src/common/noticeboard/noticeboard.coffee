define [
  'angular'
], ->
  module = angular.module 'common.noticeboard', []
  module.directive 'noticeBoard', () ->
    restrict: "A"
    scope: {}
    templateUrl: "common/noticeboard/noticeboard"
    replace: true
    link: ($scope, element, attrs) ->
      init = () ->
        $scope.$on '$noticeboard.error', handleErrorMsg

      handleErrorMsg = (data)->
        console.log "handleErrorMsg", data

      init()
