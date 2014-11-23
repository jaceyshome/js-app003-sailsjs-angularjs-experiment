module.exports = function(grunt) {
  grunt.config.set("ngtemplates", {
    dev: {
      cwd: "templates",
      src: "**/*.html",
      dest: ".tmp/public/linker/src/templates.js",
      options: {
        module: "app",
        bootstrap: function(module, script) {
          return "define(['angular'], function() {angular.module('templates', []).run([ '$templateCache', function($templateCache) {" + script + "} ]);});";
        },
        htmlmin: {
          collapseBooleanAttributes: true,
          collapseWhitespace: true,
          removeAttributeQuotes: true,
          removeComments: true,
          removeEmptyAttributes: true,
          removeRedundantAttributes: true,
          removeScriptTypeAttributes: true,
          removeStyleLinkTypeAttributes: true
        },
        url: function(url) {
          return url.replace(".html", "");
        }
      }
    }
  });
  grunt.loadNpmTasks("grunt-angular-templates");
};

//# sourceMappingURL=ngtemplates.js.map
