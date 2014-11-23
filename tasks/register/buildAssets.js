module.exports = function(grunt) {
  grunt.registerTask("buildAssets", [
    "clean:dev",
    "buildCoffee",
    "buildLess",
    "buildJade",
    "concat:dev",
    "copy:dev"
  ]);
};

//# sourceMappingURL=buildAssets.js.map
