
/**
Clean files and folders.

---------------------------------------------------------------

This grunt task is configured to clean out the contents in the .tmp/public of your
sails project.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-clean
 */
module.exports = function(grunt) {
  grunt.config.set("clean", {
    templates: [ "templates" ],
    dev: [".tmp/public/**"],
    build: ["www"],
    apiTest: ["test/api/test/**"]
  });
  grunt.loadNpmTasks("grunt-contrib-clean");
};

//# sourceMappingURL=clean.js.map
