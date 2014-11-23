
/**
grunt/pipeline.js

The order in which your css, javascript, and template files should be
compiled and linked from your views and static HTML files.

(Note that you can take advantage of Grunt-style wildcard/glob/splat expressions
for matching multiple files.)
 */
var cssFilesToInject, jsFilesToInject, templateFilesToInject;

cssFilesToInject = ["styles/**/*.css"];

jsFilesToInject = [];

templateFilesToInject = ["templates/**/*.html"];

module.exports.cssFilesToInject = cssFilesToInject.map(function(path) {
  return ".tmp/public/" + path;
});

module.exports.jsFilesToInject = jsFilesToInject.map(function(path) {
  return ".tmp/public/" + path;
});

module.exports.templateFilesToInject = templateFilesToInject.map(function(path) {
  return "assets/" + path;
});

//# sourceMappingURL=pipeline.js.map
