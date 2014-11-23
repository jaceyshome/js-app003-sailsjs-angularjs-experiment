module.exports = function(grunt) {
  grunt.config.set("mochaTest", {
    apiTest: {
      src: 'test/api/test/**/*.spec.js',
      options: {
        captureFile:"apiTestResult.html",
        reporter: 'mocha-html-reporter',
        timeout: 10000,
        quiet: true,
        bail: false
      }
    }
  });
  grunt.loadNpmTasks("grunt-mocha-test");
};

//# sourceMappingURL=mochaTest.js.map
