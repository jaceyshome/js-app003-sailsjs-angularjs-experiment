module.exports = function(grunt) {
  grunt.registerTask("watchAssets", [
    "newer:yaml",
    "json2js",
    "newer:jade:dev",
    "ngtemplates",
    "newer:coffee:dev",
    "newer:coffee:api",
    "coffeelint",
    "newer:less:dev",
    "lesslint",
    "concat:dev"
  ]);
};

//# sourceMappingURL=build.js.map
