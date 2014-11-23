"use strict";
module.exports = function(grunt) {
  var concatJson, defaultProcessNameFunction, path;
  path = require("path");
  defaultProcessNameFunction = function(name) {
    return name;
  };
  concatJson = function(files, data) {
    var basename, body, end, filename, header, includePath, namespace, options, processName;
    header = 'define([],function(){';
    options = data.options;
    namespace = options && options.namespace || "myjson";
    includePath = options && options.includePath || false;
    processName = options.processName || defaultProcessNameFunction;
    basename = void 0;
    filename = void 0;
    body = "var " + namespace + " = " + namespace + " || {};" + files.map(function(filepath) {
      basename = path.basename(filepath, ".json");
      filename = (includePath ? processName(filepath) : processName(basename));
      return "\n" + namespace + "[\"" + filename + "\"] = " + grunt.file.read(filepath) + ";";
    }).join("");
    end = "return " + namespace + ";});";
    return header + body + end;
  };
  grunt.config.set("json2js", {
    validations: {
      options: {
        namespace: 'DataValidations',
        includePath: false,
        processName: function(filename) {
          return filename.toLowerCase();
        }
      },
      src: ['.tmp/jsons/validations/*.json'],
      dest: '.tmp/public/linker/src/common/validation/attribute-models.js'
    }
  });
  grunt.registerMultiTask("json2js", "Concatenating JSON into JS", function() {
    var data;
    data = this.data;
    grunt.util.async.forEachSeries(this.files, function(f, nextFileObj) {
      var destFile, files, json;
      destFile = f.dest;
      files = f.src.filter(function(filepath) {
        if (!grunt.file.exists(filepath)) {
          grunt.log.warn("Source file \"" + filepath + "\" not found.");
          return false;
        } else {
          return true;
        }
      });
      json = concatJson(files, data);
      grunt.file.write(destFile, json);
      grunt.log.write("File \"" + destFile + "\" created.");
    });
  });
};

//# sourceMappingURL=json2js.js.map
