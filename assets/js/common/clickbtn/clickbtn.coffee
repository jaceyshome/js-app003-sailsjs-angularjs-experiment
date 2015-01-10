define [
  'angular'
  ], ->
  module = angular.module 'common.clickbtn', []
  module.directive 'ClickBtn', ($rootScope)->
    restrict:"A"
    link:($scope, element, attrs) ->
      element.attr "onclick", "return false;"
      element.attr "href", "JavaScript:void(0);"

        