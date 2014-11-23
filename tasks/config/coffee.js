
/**
Compile CoffeeScript files to JavaScript.

---------------------------------------------------------------

Compiles coffeeScript files from `assest/js` into Javascript and places them into
`.tmp/public/js` directory.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-coffee
 */
module.exports = function(grunt) {
  grunt.config.set("coffee", {
    dev: {
      expand: true,
      cwd: "src/frontend",
      src: ["**/*.coffee"],
      dest: ".tmp/public/linker/src",
      ext: ".js",
      options: {
        sourceMap: true,
        bare: true
      }
    },
    prod: {
      expand: true,
      cwd: "src/frontend",
      src: ["**/*.coffee"],
      dest: ".tmp/public/linker/src",
      ext: ".js",
      options: {
        sourceMap: true,
        bare: true
      }
    },
    apiTest: {
      expand: true,
      cwd: "test/api/src",
      src: ["**/*.spec.coffee"],
      dest: "test/api/test",
      ext: ".spec.js",
      options: {
        sourceMap: true,
        bare: true
      }
    },
    apiTestHelpers: {
      expand: true,
      cwd: "test/api/src/helpers",
      src: ["**/*.coffee"],
      dest: "test/api/test/helpers",
      ext: ".js",
      options: {
        sourceMap: true,
        bare: true
      }
    },
    api: {
      expand: true,
      cwd: "src/api",
      src: ["**/*.coffee"],
      dest: "api",
      ext: ".js",
      options: {
        sourceMap: false,
        bare: true
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-coffee");
};

//# sourceMappingURL=coffee.js.map
