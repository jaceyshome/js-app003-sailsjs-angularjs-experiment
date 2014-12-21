module.exports = function (grunt) {
	grunt.registerTask('compileAssets', [
		'clean:dev',
		'less:dev',
    'jade:dev',
    'ngtemplates',
    'coffee:dev',
    'copylibs',
    'copy:dev'
	]);
};
