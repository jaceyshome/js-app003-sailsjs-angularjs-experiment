module.exports = function(grunt) {
  grunt.config.set("jade", {
    dev: {
      expand: true,
      cwd: "src/frontend",
      src: ["**/*.jade"],
      dest: "templates/",
      ext: ".html",
      options: {
        pretty: true
      }
    },
    prod: {
      expand: true,
      cwd: "src/frontend",
      src: ["**/*.jade"],
      dest: "templates/",
      ext: ".html",
      options: {
        pretty: false,
        data: {
          deploy: true
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-contrib-jade");
};

//# sourceMappingURL=jade.js.map
