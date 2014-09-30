requirejs.config
  waitSeconds: 200
  urlArgs: "bust=" + (new Date()).getTime()
  paths:
    jquery: "lib/jquery"
    bootstrap: "lib/bootstrap"
    angular: "lib/angular"
    angular_resource: "lib/angular-resource"
    angular_ui_router: "lib/angular-ui-router"
    angular_sanitize: "lib/angular-sanitize"
    angular_animate: "lib/angular-animate"
    socket_io: "lib/socket.io"
    angular_sails: "lib/angular-sails.io"
    angular_mocks: "lib/angular-mocks"
    angular_toaster:"lib/angular-toaster"
  shim:
    socket_io:
      exports: 'socket_io'
    angular_sails:
      deps: ['jquery', 'angular', 'socket_io']
      exports: 'angular_sails'
    angular_mocks:
      deps: ['jquery', 'angular']
      exports: 'angular_mocks'
    angular:
      deps: ['jquery', 'socket_io']
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
    angular_toaster:
      deps:['angular']
      exports: 'angular_toaster'

define [
  'socket_io'
  'angular'
  'angular_animate'
  'angular_mocks'
  'angular_resource'
  'angular_ui_router'
  'angular_sails'
  'angular_toaster'
  'app/app'
  ], (socket_io,angular) ->
  return angular.element(document).ready ->
    angular.bootstrap document, ['app']
