module.exports =
    dev:
      files: [
        {
          expand: true
          cwd: "./bower_components/font-awesome/fonts/"
          src: ["**/*"]
          dest: ".tmp/public/linker/fonts"
        }
        {
        #------------------------------------------------------------------------------------------libs configuration
          ".tmp/public/linker/src/lib/require.js": "./bower_components/requirejs/require.js"
        }
        {
          ".tmp/public/linker/src/lib/respond.min.js": "./bower_components/respond/dest/respond.min.js"
        }
        {
          ".tmp/public/linker/src/lib/jquery.js": "./bower_components/jquery/dist/jquery.js"
        }
        {
          ".tmp/public/linker/src/lib/angular.js": "./bower_components/angular/angular.js"
        }
        {
          ".tmp/public/linker/src/lib/bootstrap.js": "./bower_components/bootstrap/dist/js/bootstrap.js"
        }
        {
          ".tmp/public/linker/src/lib/socket.io.js": "./assets/src/lib/socket.io.js"
        }
        {
          ".tmp/public/linker/src/lib/angular-sails.io.js": "./assets/src/lib/angular-sails.io.js"
        }
        {
          ".tmp/public/linker/src/lib/angular-animate.js": "./bower_components/angular-animate/angular-animate.js"
        }
        {
          ".tmp/public/linker/src/lib/angular-resource.js": "./bower_components/angular-resource/angular-resource.js"
        }
        {
          ".tmp/public/linker/src/lib/angular-sanitize.js": "./bower_components/angular-sanitize/angular-sanitize.js"
        }
        {
          ".tmp/public/linker/src/lib/angular-ui-router.js": "./bower_components/angular-ui-router/release/angular-ui-router.js"
        }
      ]

    prod:
      files: [
        expand: true
        cwd: "./bower_components/font-awesome/fonts/"
        src: ["**/*"]
        dest: ".tmp/public/fonts"
      ]

    build:
      files: [
        expand: true
        cwd: ".tmp/public"
        src: ["**/*"]
        dest: "www"
      ]