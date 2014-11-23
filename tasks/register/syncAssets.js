module.exports = function(grunt) {
  grunt.registerTask("syncAssets", ["jade:dev", "less:dev", "coffee:dev", "coffee:api", "coffee:apiTest", "coffee:apiTestHelper", "yaml"]);
};

//# sourceMappingURL=syncAssets.js.map
