module.exports = function (grunt) {
  grunt.registerTask('syncAssets', [
    'newer:jst:dev',
    'less:dev',
    'newer:jade:dev',
    'ngtemplates',
    'modelattributes',
    'sync:dev',
    'newer:coffee:dev'
  ]);

  grunt.loadNpmTasks('grunt-newer');

};
