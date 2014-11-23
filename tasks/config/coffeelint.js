module.exports = function(grunt) {
  grunt.config.set("coffeelint", {
    app: ["src/**/*.coffee", "src/**/*.spec.coffee"],
    options: {
      force: true,
      max_line_length: {
        value: 500
      }
    }
  });
  grunt.loadNpmTasks("grunt-coffeelint");
};

//# sourceMappingURL=coffeelint.js.map
