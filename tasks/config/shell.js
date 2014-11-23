
/**
Compile CoffeeScript files to JavaScript.

---------------------------------------------------------------

Compiles coffeeScript files from `assest/js` into Javascript and places them into
`.tmp/public/js` directory.

For usage docs see:
https://github.com/gruntjs/grunt-contrib-coffee
 */
module.exports = function(grunt) {
  grunt.config.set("shell", {
    startWebDriver: {
      command: "webdriver-manager start"
    },
    buildApiTestResult:{
      options: { stdout: true },
      command: function(){
        var commands = [], command,
          file = "apiTestResult.html",
          tmpFile = "tmp.html",
          head = "node_modules/mocha-html-reporter/docs/head.html",
          tail = "node_modules/mocha-html-reporter/docs/tail.html";
        commands.push("cat "+head+"> "+tmpFile);
        commands.push("cat "+file+">> "+tmpFile);
        commands.push("cat "+tail+">> "+tmpFile);
        commands.push("cp -r "+tmpFile+" "+file);
        commands.push("rm "+tmpFile);
        return commands.join('&&');
      }
    }
  });
  grunt.loadNpmTasks("grunt-shell");
};

//# sourceMappingURL=shell.js.map
