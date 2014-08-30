cssFilesToInject = [ "linker/styles/style.css" ]
jsFilesToInject = []
templateFilesToInject = [ "linker/**/*.html" ]
cssFilesToInject = cssFilesToInject.map((path) ->
  ".tmp/public/" + path
)
jsFilesToInject = jsFilesToInject.map((path) ->
  ".tmp/public/" + path
)
templateFilesToInject = templateFilesToInject.map((path) ->
  "assets/" + path
)

pkg = require './package.json'

module.exports =
    devJs:
      options:
        startTag: "<!--SCRIPTS-->"
        endTag: "<!--SCRIPTS END-->"
        fileTmpl: "<script src=\"%s\"></script>"
        appRoot: ".tmp/public"

      files:
        ".tmp/public/**/*.html": jsFilesToInject
        "views/**/*.html": jsFilesToInject
        "views/**/*.ejs": jsFilesToInject

    prodJs:
      options:
        startTag: "<!--SCRIPTS-->"
        endTag: "<!--SCRIPTS END-->"
        fileTmpl: "<script src=\"%s\"></script>"
        appRoot: ".tmp/public"

      files:
        ".tmp/public/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.js"]
        "views/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.js"]
        "views/**/*.ejs": [".tmp/public/min/production-<%= pkg.version %>.js"]

    devStyles:
      options:
        startTag: "<!--STYLES-->"
        endTag: "<!--STYLES END-->"
        fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">"
        appRoot: ".tmp/public"

    # cssFilesToInject defined up top
      files:
        ".tmp/public/**/*.html": cssFilesToInject
        "views/**/*.html": cssFilesToInject
        "views/**/*.ejs": cssFilesToInject

    prodStyles:
      options:
        startTag: "<!--STYLES-->"
        endTag: "<!--STYLES END-->"
        fileTmpl: "<link rel=\"stylesheet\" href=\"%s\">"
        appRoot: ".tmp/public"

      files:
        ".tmp/public/index.html": [".tmp/public/min/production-<%= pkg.version %>.css"]
        "views/**/*.html": [".tmp/public/min/production-<%= pkg.version %>.css"]
        "views/**/*.ejs": [".tmp/public/min/production-<%= pkg.version %>.css"]


    # Bring in JST template object
    devTpl:
      options:
        startTag: "<!--TEMPLATES-->"
        endTag: "<!--TEMPLATES END-->"
        fileTmpl: "<script type=\"text/javascript\" src=\"%s\"></script>"
        appRoot: ".tmp/public"

      files:
        ".tmp/public/index.html": [".tmp/public/jst.js"]
        "views/**/*.html": [".tmp/public/jst.js"]
        "views/**/*.ejs": [".tmp/public/jst.js"]


    #js /css script embed into layout.jade
    devJsJADE:
      options:
        startTag: "// SCRIPTS"
        endTag: "// SCRIPTS END"
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
        appRoot: ".tmp/public"

      files:
        "views/**/*.jade": jsFilesToInject

    prodJsJADE:
      options:
        startTag: "// SCRIPTS"
        endTag: "// SCRIPTS END"
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
        appRoot: ".tmp/public"

      files:
        "views/**/*.jade": [".tmp/public/min/production-<%= pkg.version %>.js"]

    devStylesJADE:
      options:
        startTag: "// STYLES"
        endTag: "// STYLES END"
        fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")"
        appRoot: ".tmp/public"

      files:
        "views/**/*.jade": cssFilesToInject

    prodStylesJADE:
      options:
        startTag: "// STYLES"
        endTag: "// STYLES END"
        fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")"
        appRoot: ".tmp/public"

      files:
        "views/**/*.jade": [".tmp/public/min/production-<%= pkg.version %>.css"]


    # Bring in JST template object
    devTplJADE:
      options:
        startTag: "// TEMPLATES"
        endTag: "// TEMPLATES END"
        fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
        appRoot: ".tmp/public"

      files:
        "views/**/*.jade": [".tmp/public/jst.js"]

