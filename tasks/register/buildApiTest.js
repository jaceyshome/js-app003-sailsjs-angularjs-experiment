module.exports = function(grunt) {
  grunt.registerTask("buildApiTest", [
    'clean:apiTest',
    'coffee:apiTest',
    'coffee:apiTestHelpers',
    'coffeelint',
    'mochaTest:apiTest',
    'shell:buildApiTestResult'
  ]);
};

//# sourceMappingURL=buildApiTest.js.map
