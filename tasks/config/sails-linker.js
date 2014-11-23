
/**
Autoinsert script tags (or other filebased tags) in an html file.

---------------------------------------------------------------

Automatically inject <script> tags for javascript files and <link> tags
for css files.  Also automatically links an output file containing precompiled
templates using a <script> tag.

For usage docs see:
https://github.com/Zolmeister/grunt-sails-linker
 */
module.exports = function(grunt) {
  grunt.config.set("sails-linker", {
    devJs: {
      options: {
        startTag: "<!--SCRIPTS-->",
        endTag: "<!--SCRIPTS END-->",
        fileTmpl: "<script src=\"%s\"></script>",
        appRoot: ".tmp/public"
      },
      files: {
        ".tmp/public/**/*.html": require("../pipeline").jsFilesToInject,
        "views/**/*.html": require("../pipeline").jsFilesToInject,
        "views/**/*.ejs": require("../pipeline").jsFilesToInject
      }
    },
    prodJs: {
      options: {
        startTag: "<!--SCRIPTS-->",
        endTag: "<!--SCRIPTS END-->",
        fileTmpl: "<script src=\"%s\"></script>",
        appRoot: ".tmp/public"
      },
      files: {
        ".tmp/public/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.js"],
        "views/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.js"],
        "views/**/*.ejs": [".tmp/public/min/production-<%= pkg.version %>.js"]
      }
    },
    devStyles: {
      options: {
        startTag: "<!--STYLES-->",
        endTag: "<!--STYLES END-->",
        fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">",
        appRoot: ".tmp/public"
      },
      files: {
        ".tmp/public/**/*.html": require("../pipeline").cssFilesToInject,
        "views/**/*.html": require("../pipeline").cssFilesToInject,
        "views/**/*.ejs": require("../pipeline").cssFilesToInject
      }
    },
    prodStyles: {
      options: {
        startTag: "<!--STYLES-->",
        endTag: "<!--STYLES END-->",
        fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">",
        appRoot: ".tmp/public"
      },
      files: {
        ".tmp/public/index.html": [".tmp/public/min/production-<%= pkg.version %>.css"],
        "views/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.css"],
        "views/**/*.ejs": [".tmp/public/min/production-<%= pkg.version %>.css"]
      }
    },
    devTpl: {
      options: {
        startTag: "<!--TEMPLATES-->",
        endTag: "<!--TEMPLATES END-->",
        fileTmpl: "<script type=\"text/javascript\" src=\"%s\"></script>",
        appRoot: ".tmp/public"
      },
      files: {
        ".tmp/public/index.html": [".tmp/public/jst.js"],
        "views/**/*.html": [".tmp/public/jst.js"],
        "views/**/*.ejs": [".tmp/public/jst.js"]
      }
    },
    devJsJADE: {
      options: {
        startTag: "// SCRIPTS",
        endTag: "// SCRIPTS END",
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")",
        appRoot: ".tmp/public"
      },
      files: {
        "views/**/*.jade": require("../pipeline").jsFilesToInject
      }
    },
    prodJsJADE: {
      options: {
        startTag: "// SCRIPTS",
        endTag: "// SCRIPTS END",
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")",
        appRoot: ".tmp/public"
      },
      files: {
        "views/**/*.jade": [".tmp/public/min/production-<%= pkg.version %>.js"]
      }
    },
    devStylesJADE: {
      options: {
        startTag: "// STYLES",
        endTag: "// STYLES END",
        fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")",
        appRoot: ".tmp/public"
      },
      files: {
        "views/**/*.jade": require("../pipeline").cssFilesToInject
      }
    },
    prodStylesJADE: {
      options: {
        startTag: "// STYLES",
        endTag: "// STYLES END",
        fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")",
        appRoot: ".tmp/public"
      },
      files: {
        "views/**/*.jade": [".tmp/public/min/production-<%= pkg.version %>.css"]
      }
    },
    devTplJADE: {
      options: {
        startTag: "// TEMPLATES",
        endTag: "// TEMPLATES END",
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")",
        appRoot: ".tmp/public"
      },
      files: {
        "views/**/*.jade": [".tmp/public/jst.js"]
      }
    }
  });
  grunt.loadNpmTasks("grunt-sails-linker");
};

//# sourceMappingURL=sails-linker.js.map
