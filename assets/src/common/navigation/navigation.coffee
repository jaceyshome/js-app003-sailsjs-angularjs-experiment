define [
  'angular'
  ], ->
  module = angular.module 'common.navigation', []
  module.directive 'tntNavigation', ()->
    restrict:"A"
    scope:{}
    templateUrl: "common/navigation/navigation"
    link:($scope, element, attrs) ->
