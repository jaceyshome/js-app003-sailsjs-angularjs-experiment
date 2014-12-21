module.exports = function(grunt) {
  grunt.config.set("jade", {
    dev: {
      expand: true,
      cwd: "assets/js",
      src: ["**/*.jade"],
      dest: ".tmp/templates/",
      ext: ".html",
      options: {
        pretty: true
      }
    },
    prod: {
      expand: true,
      cwd: "assets/js",
      src: ["**/*.jade"],
      dest: ".tmp/templates/",
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
