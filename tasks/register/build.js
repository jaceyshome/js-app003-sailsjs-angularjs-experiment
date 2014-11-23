module.exports = function(grunt) {
  grunt.registerTask("build", [
    "clean:build",
    "buildAssets",
    "buildLibs",
    "linkAssets",
    "copy:build"
  ]);
};

//# sourceMappingURL=build.js.map
