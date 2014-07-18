requirejs.config
  waitSeconds: 200
  urlArgs: "bust=" + (new Date()).getTime()
  paths:
    jquery: "lib/jquery"
    bootstrap: "lib/bootstrap"
    socket_io: "lib/socket.io"
    angular: "lib/angular"
    angular_resource: "lib/angular-resource"
    angular_ui_router: "lib/angular-ui-router"
    angular_sanitize: "lib/angular-sanitize"
    angular_animate: "lib/angular-animate"
    angular_socket_io: "lib/angular-sails.io"
  shim:
    angular:
      deps: ['jquery']
      exports: 'angular'
    angular_socket_io:
      deps: ['angular', 'socket_io']
      exports: 'angular_socket_io'
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
  'angular'
  'angular_resource'
  'angular_ui_router'
  'app/app'
  ], (angular, jquery) ->
  return angular.element(document).ready ->
    angular.bootstrap document, ['app']
