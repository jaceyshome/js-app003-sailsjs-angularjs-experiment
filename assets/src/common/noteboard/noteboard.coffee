define [
  'angular'
], ->
  module = angular.module 'common.noteboard', []
  module.directive 'noteBoard', () ->
    restrict: "A"
    scope: {
      messages:"="
    }
    templateUrl: "common/noteboard/noteboard"
    replace: true
    link: ($scope, element, attrs) ->
      init = () ->

      init()
