module.exports =
    dev:
      cwd: "templates"
      src: "**/*.html"
      dest: ".tmp/public/linker/src/templates.js"
      options:
        module: "app"
        bootstrap: (module, script) ->
          "define(['angular'], function() {angular.module('templates', []).run([ '$templateCache', function($templateCache) {" + script + "} ]);});"
        htmlmin:
          collapseBooleanAttributes: true
          collapseWhitespace: true
          removeAttributeQuotes: true
          removeComments: true
          removeEmptyAttributes: true
          removeRedundantAttributes: true
          removeScriptTypeAttributes: true
          removeStyleLinkTypeAttributes: true
        url: (url) ->
          url.replace ".html", ""