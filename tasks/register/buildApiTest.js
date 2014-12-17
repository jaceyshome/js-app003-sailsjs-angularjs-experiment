module.exports = function(grunt) {
  grunt.registerTask("buildApiTest", [
    'mochaTest:apiTest',
    'shell:buildApiTestResult'
  ]);
};

//# sourceMappingURL=buildApiTest.js.map
