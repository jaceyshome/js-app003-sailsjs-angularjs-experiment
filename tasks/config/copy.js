/**
 * Copy files and folders.
 *
 * ---------------------------------------------------------------
 *
 * # dev task config
 * Copies all directories and files, exept coffescript and less fiels, from the sails
 * assets folder into the .tmp/public directory.
 *
 * # build task config
 * Copies all directories nd files from the .tmp/public directory into a www directory.
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-copy
 */
module.exports = function(grunt) {

	grunt.config.set('copy', {
		dev: {
			files: [
        {
          expand: true,
          cwd: "./bower_components/",
          src: [
            "respond/dest/respond.min.js"
          ],
          dest: ".tmp/public/js/lib"
        },
        {
          expand: true,
          cwd: "./bower_components/",
          src: [
            "AngularJS-Toaster/toaster.css",
            "angular-ui-tree/source/angular-ui-tree.css"
          ],
          dest: ".tmp/public/styles"
        },
        {
          expand: true,
          cwd: "./bower_components/font-awesome/fonts/",
          src: ["**/*"],
          dest: ".tmp/public/fonts"
        },
        {
          expand: true,
          cwd: "./bower_components/bootstrap/fonts/",
          src: ["**/*"],
          dest: ".tmp/public/fonts"
        },
        {
          expand: true,
          cwd: './assets',
          src: ['**/*.!(coffee|less|jade)'],
          dest: '.tmp/public'
        }
      ]
		},
		build: {
			files: [{
				expand: true,
				cwd: '.tmp/public',
				src: ['**/*'],
				dest: 'www'
			}]
		}
	});

	grunt.loadNpmTasks('grunt-contrib-copy');
};
