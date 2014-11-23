module.exports = function(grunt) {
  grunt.config.set("yaml", {
    validations: {
      expand: true,
      cwd: "assets/validations",
      src: "**/*.yml",
      dest: ".tmp/jsons/validations"
    }
  });
  grunt.loadNpmTasks("grunt-yaml");
};

//# sourceMappingURL=yaml.js.map
