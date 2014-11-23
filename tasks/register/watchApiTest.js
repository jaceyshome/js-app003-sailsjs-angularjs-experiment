module.exports = function(grunt) {
  grunt.registerTask("watchApiTest", [
    'newer:coffee:apiTestHelpers',
    'newer:coffee:apiTest',
    'coffeelint',
    'mochaTest:apiTest',
    'shell:buildApiTestResult'
  ]);
};

//# sourceMappingURL=watchApiTest.js.map
