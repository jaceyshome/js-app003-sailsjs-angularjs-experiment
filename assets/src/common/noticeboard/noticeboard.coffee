define [
  'angular'
], ->
  module = angular.module 'common.noticeboard', []
  module.directive 'noticeBoard', () ->
    restrict: "A"
    scope: {
      messages:"="
    }
    templateUrl: "common/noticeboard/noticeboard"
    replace: true
    link: ($scope, element, attrs) ->
      init = () ->

      init()
