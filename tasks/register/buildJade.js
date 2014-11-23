module.exports = function(grunt) {
  grunt.registerTask("buildJade", ["clean:templates", "jade:dev", "ngtemplates", "clean:templates"]);
};

//# sourceMappingURL=buildJade.js.map
