
/**
Precompiles Underscore templates to a `.jst` file.

---------------------------------------------------------------

(i.e. basically it takes HTML files and turns them into tiny little
javascript functions that you pass data to and return HTML. This can
speed up template rendering on the client, and reduce bandwidth usage.)

For usage docs see:
https://github.com/gruntjs/grunt-contrib-jst
 */
module.exports = function(grunt) {
  var templateFilesToInject;
  templateFilesToInject = ["templates/**/*.html"];
  grunt.config.set("jst", {
    dev: {
      files: {
        ".tmp/public/jst.js": require("../pipeline").templateFilesToInject
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-jst");
};

//# sourceMappingURL=jst.js.map
