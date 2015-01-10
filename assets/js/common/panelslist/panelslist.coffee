define [
  'angular'
], ->
  module = angular.module 'common.panelslist', []
  module.directive 'panelsList', () ->
    restrict: "A"
    scope: {
      settings: "="
    }
    replace: true
    templateUrl: "common/panelslist/panelslist"
    link: ($scope, $element, $attrs) ->
      console.log "$scope.settings", $scope.settings
      init = () ->
        undefined
      init()
