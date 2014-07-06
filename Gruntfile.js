/**
 * Gruntfile
 *
 * If you created your Sails app with `sails new foo --linker`,
 * the following files will be automatically injected (in order)
 * into the EJS and HTML files in your `views` and `assets` folders.
 *
 * At the top part of this file, you'll find a few of the most commonly
 * configured options, but Sails' integration with Grunt is also fully
 * customizable.  If you'd like to work with your assets differently
 * you can change this file to do anything you like!
 *
 * More information on using Grunt to work with static assets:
 * http://gruntjs.com/configuring-tasks
 */

module.exports = function (grunt) {

  /**
   * CSS files to inject in order
   * (uses Grunt-style wildcard/glob/splat expressions)
   *
   * By default, Sails also supports LESS in development and production.
   * To use SASS/SCSS, Stylus, etc., edit the `sails-linker:devStyles` task
   * below for more options.  For this to work, you may need to install new
   * dependencies, e.g. `npm install grunt-contrib-sass`
   */
  var cssFilesToInject = [
    'linker/styles/style.css'
  ];
  /**
   * Javascript files to inject in order
   * (uses Grunt-style wildcard/glob/splat expressions)
   *
   * To use client-side CoffeeScript, TypeScript, etc., edit the
   * `sails-linker:devJs` task below for more options.
   */
  var jsFilesToInject = [

    // Below, as a demonstration, you'll see the built-in dependencies
    // linked in the proper order
    // 'linker/js/require.js'

    // All of the rest of your app scripts imported here
    // 'linker/**/*.js'
  ];
  /**
   * Client-side HTML templates are injected using the sources below
   * The ordering of these templates shouldn't matter.
   * (uses Grunt-style wildcard/glob/splat expressions)
   *
   * By default, Sails uses JST templates and precompiles them into
   * functions for you.  If you want to use jade, handlebars, dust, etc.,
   * edit the relevant sections below.
   */
  var templateFilesToInject = [
    'linker/**/*.html'
  ];
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  //
  // DANGER:
  //
  // With great power comes great responsibility.
  //
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  // Modify css file injection paths to use 
  cssFilesToInject = cssFilesToInject.map(function (path) {
    return '.tmp/public/' + path;
  });
  // Modify js file injection paths to use 
  jsFilesToInject = jsFilesToInject.map(function (path) {
    return '.tmp/public/' + path;
  });
  templateFilesToInject = templateFilesToInject.map(function (path) {
    return 'assets/' + path;
  });

  // --------------------------------------------------------------------Get path to core grunt dependencies from Sails
  var depsPath = grunt.option('gdsrc') || 'node_modules/sails/node_modules';
  grunt.loadTasks(depsPath + '/grunt-contrib-clean/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-copy/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-concat/tasks');
  grunt.loadTasks(depsPath + '/grunt-sails-linker/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-jst/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-watch/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-uglify/tasks');
  grunt.loadTasks(depsPath + '/grunt-contrib-cssmin/tasks');
  //----------------------------------------------------------------------------------------------Packages for front end
  grunt.loadNpmTasks('grunt-newer');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-lesslint');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-requirejs-config');

  // ---------------------------------------------------------------------------------------------Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    copy: {
      jade:{
        files:[
          {
            expand: true,
            cwd: './assets/src/',
            src: ['**/*.jade'],
            dest: 'views/'
        }]
      },
      dev: {
        files: [
          {
            expand: true,
            cwd: './assets/src/',
            src: ['**/*.!(coffee|less|js|jade)'],
            dest: '.tmp/public/linker/'
          },
          {
            expand: true,
            cwd: './bower_components/font-awesome/fonts/',
            src: ['**/*'],
            dest: '.tmp/public/linker/fonts'
          },
          //------------------------------------------------------------------------------------------libs configuration
          { '.tmp/public/linker/src/lib/require.js': './bower_components/requirejs/require.js' },
          { '.tmp/public/linker/src/lib/respond.min.js': './bower_components/respond/dest/respond.min.js' },
          { '.tmp/public/linker/src/lib/jquery.js': './bower_components/jquery/dist/jquery.js' },
          { '.tmp/public/linker/src/lib/angular.js': './bower_components/angular/angular.js' },
          { '.tmp/public/linker/src/lib/bootstrap.js': './bower_components/bootstrap/dist/js/bootstrap.js' },
          { '.tmp/public/linker/src/lib/socket.io.js':         './bower_components/socket.io-client/socket.io.js' },
          { '.tmp/public/linker/src/lib/angular-socket.io.js': './bower_components/angular-socket-io/socket.js' },
          { '.tmp/public/linker/src/lib/angular-animate.js': './bower_components/angular-animate/angular-animate.js' },
          { '.tmp/public/linker/src/lib/angular-resource.js': './bower_components/angular-resource/angular-resource.js' },
          { '.tmp/public/linker/src/lib/angular-sanitize.js': './bower_components/angular-sanitize/angular-sanitize.js' },
          { '.tmp/public/linker/src/lib/angular-ui-router.js': './bower_components/angular-ui-router/release/angular-ui-router.js' }
        ]
      },
      prod : {
        files : [
          {
            expand: true,
            cwd: './bower_components/font-awesome/fonts/',
            src: ['**/*'],
            dest: '.tmp/public/fonts'
          }
        ]
      },
      build: {
        files: [
          {
            expand: true,
            cwd: '.tmp/public',
            src: ['**/*'],
            dest: 'www'
          }
        ]
      }
    },
    jst: {
      dev: {
        // To use other sorts of templates (mustache), specify the regexp below:
//        options: {
//           templateSettings: {
//             interpolate: /\{\{(.+?)\}\}/g
//           }
//        },
        files: {
          '.tmp/public/jst.js': templateFilesToInject
        }
      }
    },
    coffee: {
      dev:{
        expand: true,
        cwd:"assets",
        src:["**/*.coffee"],
        dest:".tmp/public/linker/",
        ext:".js",
        options:{
          sourceMap:true,
          bare:true
        }
      },
      prod:{
        expand: true,
        cwd:"assets",
        src:["**/*.coffee"],
        dest:".tmp/public/linker/",
        ext:".js",
        options:{
          sourceMap:true,
          bare:true
        }
      }
    },
    coffeelint: {
      app: "assets/**/*.coffee",
      options: {
        force: true,
        max_line_length: {
          value: 120
        }
      }
    },
    less: {
      dev: {
        files: {
          ".tmp/public/linker/styles/style.css": "assets/src/app-src.less"
        },
        options: {
          sourceMap: true
        }
      },
      prod: {
        files: {
          ".tmp/public/linker/styles/style.css": "assets/src/app-src.less"
        },
        options: {
          sourceMap: false,
          cleancss: true,
          compress: true
        }
      }
    },
    lesslint: {
      src: ['assets/src/app-src.less'],
      options: {
        imports: ['assets/src/**/*.less'],
        csslint: {
          "unqualified-attributes": false,
          "adjoining-classes": false,
          "qualified-headings": false,
          "unique-headings": false
        }
      }
    },
//    requirejs: {
//      main: {
//        options: {
//          baseUrl: "linker/src/app",
//          mainConfigFile: "linker/src/app/main.js",
//          name: "main",
//          wrap: true,
//          optimize: "uglify2",
//          out: "bin/assets/js/deploy/main.js",
//          include: ['../lib/almond/almond.js'],
//          insertRequire: ['main']
//        }
//      }
//    },
    //----------------------------------------------------------------------------------- clean config
    clean: {
      view:['views/**'],
      dev: ['.tmp/public/**'],
      build: ['www']
    },
    //------------------------------------------------------------------------------------ optimization config
    concat: {
      js: {
        src: jsFilesToInject,
        dest: '.tmp/public/concat/production.js'
      },
      css: {
        src: cssFilesToInject,
        dest: '.tmp/public/concat/production.css'
      }
    },
    uglify: {
      dist: {
        src: ['.tmp/public/concat/production.js'],
        dest: '.tmp/public/min/production-<%= pkg.version %>.js'
      },
      options : {
        mangle : false
      }
    },
    cssmin: {
      dist: {
        src: ['.tmp/public/concat/production.css'],
        dest: '.tmp/public/min/production-<%= pkg.version %>.css'
      }
    },

    //-----------------------------------------------------------------------------js /css script embed into layout.ejs
    'sails-linker': {
      devJs: {
        options: {
          startTag: '<!--SCRIPTS-->',
          endTag: '<!--SCRIPTS END-->',
          fileTmpl: '<script src="%s"></script>',
          appRoot: '.tmp/public'
        },
        files: {
          '.tmp/public/**/*.html': jsFilesToInject,
          'views/**/*.html': jsFilesToInject,
          'views/**/*.ejs': jsFilesToInject
        }
      },
      prodJs: {
        options: {
          startTag: '<!--SCRIPTS-->',
          endTag: '<!--SCRIPTS END-->',
          fileTmpl: '<script src="%s"></script>',
          appRoot: '.tmp/public'
        },
        files: {
          '.tmp/public/**/*.html': ['.tmp/public/min/production-<%= pkg.version %>.js'],
          'views/**/*.html': ['.tmp/public/min/production-<%= pkg.version %>.js'],
          'views/**/*.ejs': ['.tmp/public/min/production-<%= pkg.version %>.js']
        }
      },
      devStyles: {
        options: {
          startTag: '<!--STYLES-->',
          endTag: '<!--STYLES END-->',
          fileTmpl: '<link rel="stylesheet" href="%s">',
          appRoot: '.tmp/public'
        },
        // cssFilesToInject defined up top
        files: {
          '.tmp/public/**/*.html': cssFilesToInject,
          'views/**/*.html': cssFilesToInject,
          'views/**/*.ejs': cssFilesToInject
        }
      },
      prodStyles: {
        options: {
          startTag: '<!--STYLES-->',
          endTag: '<!--STYLES END-->',
          fileTmpl: '<link rel="stylesheet" href="%s">',
          appRoot: '.tmp/public'
        },
        files: {
          '.tmp/public/index.html': ['.tmp/public/min/production-<%= pkg.version %>.css'],
          'views/**/*.html': ['.tmp/public/min/production-<%= pkg.version %>.css'],
          'views/**/*.ejs': ['.tmp/public/min/production-<%= pkg.version %>.css']
        }
      },
      // Bring in JST template object
      devTpl: {
        options: {
          startTag: '<!--TEMPLATES-->',
          endTag: '<!--TEMPLATES END-->',
          fileTmpl: '<script type="text/javascript" src="%s"></script>',
          appRoot: '.tmp/public'
        },
        files: {
          '.tmp/public/index.html': ['.tmp/public/jst.js'],
          'views/**/*.html': ['.tmp/public/jst.js'],
          'views/**/*.ejs': ['.tmp/public/jst.js']
        }
      },

      //---------------------------------------------------------------------------js /css script embed into layout.jade
      devJsJADE: {
        options: {
          startTag: '// SCRIPTS',
          endTag: '// SCRIPTS END',
          fileTmpl: 'script(type="text/javascript", src="%s")',
          appRoot: '.tmp/public'
        },
        files: {
          'views/**/*.jade': jsFilesToInject
        }
      },
      prodJsJADE: {
        options: {
          startTag: '// SCRIPTS',
          endTag: '// SCRIPTS END',
          fileTmpl: 'script(type="text/javascript", src="%s")',
          appRoot: '.tmp/public'
        },
        files: {
          'views/**/*.jade': ['.tmp/public/min/production-<%= pkg.version %>.js']
        }
      },
      devStylesJADE: {
        options: {
          startTag: '// STYLES',
          endTag: '// STYLES END',
          fileTmpl: 'link(rel="stylesheet", href="%s")',
          appRoot: '.tmp/public'
        },
        files: {
          'views/**/*.jade': cssFilesToInject
        }
      },
      prodStylesJADE: {
        options: {
          startTag: '// STYLES',
          endTag: '// STYLES END',
          fileTmpl: 'link(rel="stylesheet", href="%s")',
          appRoot: '.tmp/public'
        },
        files: {
          'views/**/*.jade': ['.tmp/public/min/production-<%= pkg.version %>.css']
        }
      },
      // Bring in JST template object
      devTplJADE: {
        options: {
          startTag: '// TEMPLATES',
          endTag: '// TEMPLATES END',
          fileTmpl: 'script(type="text/javascript", src="%s")',
          appRoot: '.tmp/public'
        },
        files: {
          'views/**/*.jade': ['.tmp/public/jst.js']
        }
      }
    },

    //-------------------------------------------------------------------------------------------------------watch tasks
    watch: {
      api: {
        // API files to watch:
        files: ['api/**/*']
      },
      assets: {
        // Assets to watch:
        files: ['assets/src/**/*'],
        // When assets are changed:
        tasks: ['watchAssets', 'linkAssets']
      }
    }
  });

  //----------------------------------------------------------------------------------------------------------base tasks
  grunt.registerTask('watchCoffee',['newer:coffee:dev', 'coffeelint']);
  grunt.registerTask('watchLess',['newer:less:dev', 'lesslint']);
  grunt.registerTask('watchJade',['newer:copy:jade']);
  grunt.registerTask('buildCoffee',['coffee:dev', 'coffeelint']);
  grunt.registerTask('buildLess',['less:dev', 'lesslint']);
  grunt.registerTask('buildJade',['copy:jade']);

  //-----------------------------------------------------------------------------------------------When Sails is lifted:
  grunt.registerTask('default', [
    'watch'
  ]);

  grunt.registerTask('watchAssets', [
    'watchCoffee',
    'watchLess',
    'watchJade'
  ]);
  grunt.registerTask('buildAssets', [
    'clean:dev',
    'buildCoffee',
    'buildLess',
    'buildJade',
    'copy:dev'
  ]);
  // Update link/script/template references in `assets` index.html
  grunt.registerTask('linkAssets', [
    'sails-linker:devJs',
    'sails-linker:devStyles',
    'sails-linker:devTpl',
    'sails-linker:devJsJADE',
    'sails-linker:devStylesJADE',
    'sails-linker:devTplJADE'
  ]);
  // Build the assets into a web accessible folder.
  // (handy for phone gap apps, chrome extensions, etc.)
  grunt.registerTask('build', [
    'clean:build',
    'buildAssets',
    'linkAssets',
    'copy:build'
  ]);
  // When sails is lifted in production
  grunt.registerTask('prod', [
    'buildAssets',
    'copy:prod',
    'concat',
    'uglify',
    'cssmin',
    'sails-linker:prodJs',
    'sails-linker:prodStyles',
    'sails-linker:devTpl',
    'sails-linker:prodJsJADE',
    'sails-linker:prodStylesJADE',
    'sails-linker:devTplJADE'
  ]);

  // When API files are changed:
  // grunt.event.on('watch', function(action, filepath) {
  //   grunt.log.writeln(filepath + ' has ' + action);

  //   // Send a request to a development-only endpoint on the server
  //   // which will reuptake the file that was changed.
  //   var baseurl = grunt.option('baseurl');
  //   var gruntSignalRoute = grunt.option('signalpath');
  //   var url = baseurl + gruntSignalRoute + '?action=' + action + '&filepath=' + filepath;

  //   require('http').get(url)
  //   .on('error', function(e) {
  //     console.error(filepath + ' has ' + action + ', but could not signal the Sails.js server: ' + e.message);
  //   });
  // });
};
