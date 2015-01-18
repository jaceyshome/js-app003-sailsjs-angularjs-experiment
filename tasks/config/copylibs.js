var fs = require('fs');
module.exports = function(grunt) {
  grunt.registerTask('copylibs', 'Copy requried libs in app/main.coffee from bower_component', function() {
    var bowerComponentPath, fileString, fromPath, libPath, options, path, pathString, pathStrings, toPath, _i, _len, _results,srcPath;
    bowerComponentPath = 'bower_components';
    libPath = ".tmp/public/js/lib";
    srcPath = "assets/js/src.coffee";
    options = {
      encoding: 'utf8'
    };
    fileString = grunt.file.read(srcPath);
    pathStrings = ((fileString.split('paths:')[1]).split('shim:')[0]).split(/\n/g);
    _results = [];
    for (_i = 0, _len = pathStrings.length; _i < _len; _i++) {
      pathString = pathStrings[_i];
      path = pathString.trim().split(":")[1];
      if (!path) {
        continue;
      }
      toPath = eval(path.replace("lib", libPath)) + '.js';
      fromPath = eval(path.replace("lib", bowerComponentPath)) + '.js';
      if (fs.existsSync(fromPath)){
        _results.push(grunt.file.copy(fromPath, toPath, options));
      }
    }
    return _results;
  });
};
