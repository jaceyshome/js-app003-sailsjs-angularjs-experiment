
/**
 Run predefined tasks whenever watched file patterns are added, changed or deleted.

 ---------------------------------------------------------------

 Watch for changes on
 - files in the `assets` folder
 - the `tasks/pipeline.js` file
 and re-run the appropriate tasks.

 For usage docs see:
 https://github.com/gruntjs/grunt-contrib-watch
 */
module.exports = function(grunt) {
  grunt.config.set("watch", {
    assets: {
      files: ["src/frontend/**/*", "assets/validations/**/*", "src/api/**/*"],
      tasks: ["linkAssets","watchAssets"]
    },
    apiTest:{
      files: ["test/api/src/**/*"],
      tasks: ["watchApiTest"]
    }
  });
  grunt.loadNpmTasks("grunt-contrib-watch");
};

//# sourceMappingURL=watch.js.map
