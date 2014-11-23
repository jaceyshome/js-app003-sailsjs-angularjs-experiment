
/**
Compiles LESS files into CSS.

---------------------------------------------------------------

Only the `assets/styles/importer.less` is compiled.
This allows you to control the ordering yourself, i.e. import your
dependencies, mixins, variables, resets, etc. before other stylesheets)

For usage docs see:
https://github.com/gruntjs/grunt-contrib-less
 */
module.exports = function(grunt) {
  grunt.config.set("less", {
    dev: {
      files: {
        ".tmp/public/linker/styles/style.css": "src/frontend/src.less"
      },
      options: {
        sourceMap: true
      }
    },
    prod: {
      files: {
        ".tmp/public/linker/styles/style.css": "src/frontend/src.less"
      },
      options: {
        sourceMap: false,
        cleancss: true,
        compress: true
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-less");
};

//# sourceMappingURL=less.js.map
