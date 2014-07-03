tests = []
for file of window.__karma__.files
  #console.log "file", file
  window.__karma__.files[file.replace(/^\//, '')] = window.__karma__.files[file] # CC - to remove timestamp error
  tests.push file  if /.spec\.js$/.test(file)  if window.__karma__.files.hasOwnProperty(file)
#console.log "tests", tests

requirejs.config
  baseUrl: "base/bin/assets/js/app/"
  paths:
    jquery: "../lib/jquery/jquery"
    bootstrap: "../lib/bootstrap/dist/js/bootstrap"
    angular: "../lib/angular/angular"
    angular_resource: "../lib/angular-resource/angular-resource"
    angular_ui_router: "../lib/angular-ui-router/index"
    angular_sanitize: "../lib/angular-sanitize/angular-sanitize"
    angular_animate: "../lib/angular-animate/angular-animate"
    angular_mocks: "../lib/angular-mocks/angular-mocks"
    xml2json: "../lib/xml2json/index"
    videojs: "../lib/video-js/video.dev"
    bowser: "../lib/bowser/bowser"
    scorm:"../lib/scorm-api-wrapper/src/JavaScript/SCORM_API_wrapper"
    tincan:"../lib/tincan/build/tincan"
    flash_detect:"../lib/flash_detect/index"
    signals:"../lib/signals/dist/signals"
    moment:"../lib/moment/moment"
    should:"../lib/should/should"
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
    angular_mocks:
      deps: ['angular']
      exports: 'angular_mocks'

  
  # ask Require.js to load these files (all our tests)
  deps: tests
  
  # start test run, once Require.js is done
  callback: window.__karma__.start
