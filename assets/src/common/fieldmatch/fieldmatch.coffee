define [
  'angular'
], ->
  directiveId = 'fieldMatch'
  module = angular.module 'common.fieldmatch.directive', []
  module.directive directiveId, ($parse) ->
    directive = {
      link: link
      restrict: "A"
      require: "?ngModel"
    }
    link = ($scope, element, attrs, ctrl) ->
      password = null
      init = ->

        if !ctrl then return #if ngModel is not defined, do nothing
        password = $parse(attrs[directiveId])
        ctrl.$parsers.unshift(validator)
        ctrl.$formatters.push(validator)
        attrs.$observe(directiveId, ()->
          validator(ctrl.$viewValue)
        )
      validator = (val)->
        console.log "here"
        ctrl.$setValidity('match', (val is password($scope)))
        val

      init()

    directive