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
    angular_sails: "lib/ngsails.io"
    angular_ui_tree: "lib/angular-ui-tree.min"
    angular_material: "lib/angular-material.min"
    sails_io: "lib/sails.io"
    angular_mocks: "lib/angular-mocks"
    angular_toaster:"lib/angular-toaster"
  shim:
    sails_io:
      deps:['angular']
      exports: 'sails_io'
    angular_sails:
      deps:['sails_io']
      exports: 'angular_sails'
    angular_mocks:
      deps: ['jquery', 'angular']
      exports: 'angular_mocks'
    angular:
      deps: ['jquery']
      exports: 'angular'
    angular_ui_tree:
      deps: ['jquery', 'angular']
      exports: 'angular_ui_tree'
    angular_material:
      deps: ['jquery', 'angular']
      exports: 'angular_material'
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
  'angular'
  'angular_animate'
  'angular_mocks'
  'angular_resource'
  'angular_ui_router'
  'angular_toaster'
  'angular_ui_tree'
  'angular_material'
  'app/app'
  ], (angular) ->
  return angular.element(document).ready ->
    angular.bootstrap document, ['app']
