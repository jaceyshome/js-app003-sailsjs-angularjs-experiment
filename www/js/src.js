requirejs.config({
  waitSeconds: 200,
  urlArgs: "bust=" + (new Date()).getTime(),
  paths: {
    jquery: "lib/jquery/dist/jquery",
    bootstrap: "lib/bootstrap/dist/js/bootstrap",
    angular: "lib/angular/angular",
    angular_resource: "lib/angular-resource/angular-resource",
    angular_ui_router: "lib/angular-ui-router/release/angular-ui-router",
    angular_sanitize: "lib/angular-sanitize/angular-sanitize",
    angular_animate: "lib/angular-animate/angular-animate",
    angular_sails: "lib/angularSails/dist/ngsails.io",
    angular_ui_tree: "lib/angular-ui-tree",
    angular_material: "lib/angular-material/angular-material",
    sails_io: "lib/sails.io.js/dist/sails.io",
    angular_toaster: "lib/AngularJS-Toaster/toaster"
  },
  shim: {
    sails_io: {
      deps: ['angular'],
      exports: 'sails_io'
    },
    angular_sails: {
      deps: ['sails_io'],
      exports: 'angular_sails'
    },
    angular: {
      deps: ['jquery'],
      exports: 'angular'
    },
    angular_ui_tree: {
      deps: ['jquery', 'angular'],
      exports: 'angular_ui_tree'
    },
    angular_material: {
      deps: ['jquery', 'angular'],
      exports: 'angular_material'
    },
    bootstrap: {
      deps: ['jquery'],
      exports: 'bootstrap'
    },
    angular_resource: {
      deps: ['angular'],
      exports: 'angular_resource'
    },
    angular_ui_router: {
      deps: ['angular'],
      exports: 'angular_ui_router'
    },
    angular_sanitize: {
      deps: ['angular'],
      exports: 'angular_sanitize'
    },
    angular_animate: {
      deps: ['angular'],
      exports: 'angular_animate'
    },
    angular_toaster: {
      deps: ['angular'],
      exports: 'angular_toaster'
    }
  }
});

define(['angular', 'angular_animate', 'angular_resource', 'angular_ui_router', 'angular_toaster', 'angular_ui_tree', 'angular_material', 'templates', 'app/app'], function(angular) {
  return angular.element(document).ready(function() {
    return angular.bootstrap(document, ['app']);
  });
});

//# sourceMappingURL=src.js.map
