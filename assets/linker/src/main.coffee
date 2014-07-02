requirejs.config
  waitSeconds: 200
  urlArgs: "bust=" + (new Date()).getTime()
  paths:
    jquery: "../lib/jquery/jquery"
    bootstrap: "../lib/bootstrap/dist/js/bootstrap"
    angular: "../lib/angular/angular"
    angular_resource: "../lib/angular-resource/angular-resource"
    angular_ui_router: "../lib/angular-ui-router/index"
    angular_sanitize: "../lib/angular-sanitize/angular-sanitize"
    angular_animate: "../lib/angular-animate/angular-animate"
  shim:
    angular:
      deps: ['jquery']
      exports: 'angular'
    bootstrap:
      deps: ['jquery']
      exports: 'bootstrap'
    angular_resource:
      deps: ['angular']
      exports: 'angular_resource'
    angular_ui_router:
      deps: ['angular']
      exports: 'angular_ui_router'
    angular_sanitize:
      deps: ['angular']
      exports: 'angular_sanitize'
    angular_animate:
      deps: ['angular']
      exports: 'angular_animate'

define [
  'jquery'
  'angular'
  'angular_resource'
  'angular_ui_router'
  'angular_sanitize'
  'angular_animate'
  'app/main'
  ], (angular, bowser) ->
  return angular.element(document).ready ->
    return angular.bootstrap document, ['app']
