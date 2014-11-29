
/**
Copy files and folders.

---------------------------------------------------------------

 * dev task config
Copies all directories and files, exept coffescript and less fiels, from the sails
assets folder into the .tmp/public directory.

 * build task config
Copies all directories nd files from the .tmp/public directory into a www directory.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-copy
 */
module.exports = function(grunt) {
  grunt.config.set("copy", {
    dev: {
      files: [
        {
          expand: true,
          cwd: "./bower_components/font-awesome/fonts/",
          src: ["**/*"],
          dest: ".tmp/public/linker/fonts"
        }, {
          ".tmp/public/linker/src/lib/require.js": "./bower_components/requirejs/require.js"
        }, {
          ".tmp/public/linker/src/lib/respond.min.js": "./bower_components/respond/dest/respond.min.js"
        }, {
          ".tmp/public/linker/src/lib/jquery.js": "./bower_components/jquery/dist/jquery.js"
        }, {
          ".tmp/public/linker/src/lib/angular-mocks.js": "./bower_components/angular-mocks/angular-mocks.js"
        }, {
          ".tmp/public/linker/src/lib/angular.js": "./bower_components/angular/angular.js"
        }, {
          ".tmp/public/linker/src/lib/bootstrap.js": "./bower_components/bootstrap/dist/js/bootstrap.js"
        }, {
          ".tmp/public/linker/src/lib/ngsails.io.js": "./bower_components/angularSails/dist/ngsails.io.js"
        },{
          ".tmp/public/linker/src/lib/sails.io.js": "./src/frontend/lib/sails.io.js"
        }, {
          ".tmp/public/linker/src/lib/angular-animate.js": "./bower_components/angular-animate/angular-animate.js"
        }, {
          ".tmp/public/linker/src/lib/angular-resource.js": "./bower_components/angular-resource/angular-resource.js"
        }, {
          ".tmp/public/linker/src/lib/angular-sanitize.js": "./bower_components/angular-sanitize/angular-sanitize.js"
        }, {
          ".tmp/public/linker/src/lib/angular-ui-router.js": "./bower_components/angular-ui-router/release/angular-ui-router.js"
        }, {
          ".tmp/public/linker/src/lib/angular-material.min.js": "./bower_components/angular-material/angular-material.min.js"
        }, {
          ".tmp/public/linker/src/lib/angular-ui-tree.min.js": "./bower_components/angular-ui-tree/dist/angular-ui-tree.min.js"
        }, {
          ".tmp/public/linker/src/lib/angular-toaster.js": "./bower_components/AngularJS-Toaster/toaster.js"
        }, {
          ".tmp/public/linker/src/lib/almond.js": "./bower_components/almond/almond.js"
        }, {
          ".tmp/public/linker/styles/toaster.css": "./bower_components/AngularJS-Toaster/toaster.css"
        }
      ]
    },
    prod: {
      files: [
        {
          expand: true,
          cwd: "./bower_components/font-awesome/fonts/",
          src: ["**/*"],
          dest: ".tmp/public/fonts"
        }
      ]
    },
    build: {
      files: [
        {
          expand: true,
          cwd: ".tmp/public",
          src: ["**/*"],
          dest: "www"
        }
      ]
    }
  });
  grunt.loadNpmTasks("grunt-contrib-copy");
};

//# sourceMappingURL=copy.js.map
