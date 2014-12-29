var fs = require("fs");

module.exports = function(grunt) {
  grunt.registerTask('modelattributes', 'generate model attributes', function() {
    var dest, srcDir, files, attributes = {}, path, model,key,startMarker,endMarker,data;
    dest = ".tmp/public/js/model-attributes.js";
    srcDir = "api/models";
    startMarker = "define([], function() {return";
    endMarker = ";});";
    files = fs.readdirSync(srcDir);
    files.forEach(function(element, index, array){
      path = '../../' + srcDir + '/';
      key = element.substr(0, element.lastIndexOf('.')) || element;
      path += key;
      model = require(path);
      attributes[key] = model.attributes;
    });
    data = startMarker+JSON.stringify(attributes)+endMarker;
    fs.writeFileSync(dest,data,'utf8');
  });
};
