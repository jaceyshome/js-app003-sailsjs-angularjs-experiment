module.exports = function(grunt) {
  grunt.config.set("protractor", {
    options: {
      keepAlive: true,
      noColor: false,
      configFile: "protractorConf.js",
      dev: {
        options: {
          args: {
            specs: ["e2e/**/*.spec.coffee"],
            params: {
              app: "http://localhost:1337",
              appRoot: "http://localhost:1337",
              logout: "http://localhost:1337/logout"
            }
          }
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-protractor-runner");
};

//# sourceMappingURL=protactor.js.map
