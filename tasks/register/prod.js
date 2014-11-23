module.exports = function(grunt) {
  grunt.registerTask("prod", ["buildAssets", "linkAssets", "copy:prod", "concat:prod", "uglify", "cssmin"]);
};

//# sourceMappingURL=prod.js.map
