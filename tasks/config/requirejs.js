module.exports = function(grunt) {
  grunt.config.set("requirejs", {
    main: {
      options: {
        baseUrl: "linker/src",
        mainConfigFile: "linker/src/src.js",
        name: "src",
        wrap: true,
        optimize: "uglify2",
        out: "linker/src.js",
        include: ['linker/src/lib/almond.js'],
        insertRequire: ['src']
      }
    }
  });
  grunt.loadNpmTasks("grunt-requirejs-config");
};

//# sourceMappingURL=requirejs.js.map
