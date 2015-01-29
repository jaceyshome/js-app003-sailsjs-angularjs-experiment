module.exports = function (grunt) {
	grunt.registerTask('linkAssets', [
//		'sails-linker:devJs',
		'newer:sails-linker:devStyles',
//		'sails-linker:devTpl',
//		'sails-linker:devJsJade',
		'newer:sails-linker:devStylesJade'
//		'sails-linker:devTplJade'
	]);

  grunt.loadNpmTasks('grunt-newer');
};
