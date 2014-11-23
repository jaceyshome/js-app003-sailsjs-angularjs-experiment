define [
  'angular'
], ->
  module = angular.module 'common.fieldmatch.directive', []
  module.directive 'fieldMatch', ($parse) ->
    scope:{}
    restrict: "A"
    require: "?ngModel"
    link: ($scope, element, attrs, ctrl) ->
      init = ->
        if !ctrl then return #if ngModel is not defined, do nothing
        ctrl.$parsers.unshift(validator)
        ctrl.$formatters.push(validator)
        attrs.$observe('fieldMatch', ()->
          validator(ctrl.$viewValue)
        )
      validator = (val)->
        ctrl.$setValidity('match', (val is attrs['fieldMatch']))
        val

      init()
