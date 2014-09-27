# * This task is grunt-json for require js
# * grunt-json
# * https://github.com/wilsonpage/grunt-json
# *
# * Copyright (c) 2012 Wilson Page
# * Licensed under the MIT license.
# 
"use strict"
module.exports = (grunt) ->
  path = require("path")
  defaultProcessNameFunction = (name) ->
    name

  concatJson = (files, data) ->
    header = 'define([],function(){'
    options = data.options
    namespace = options and options.namespace or "myjson" # Allows the user to customize the namespace but will have a default if one is not given.
    includePath = options and options.includePath or false # Allows the user to include the full path of the file and the extension.
    processName = options.processName or defaultProcessNameFunction # Allows the user to modify the path/name that will be used as the identifier.
    basename = undefined
    filename = undefined
    body = "var " + namespace + " = " + namespace + " || {};" + files.map((filepath) ->
      basename = path.basename(filepath, ".json")
      filename = (if (includePath) then processName(filepath) else processName(basename))
      "\n" + namespace + "[\"" + filename + "\"] = " + grunt.file.read(filepath) + ";"
    ).join("")
    end = "return "+namespace+";});"
    return header+body+end

  grunt.registerMultiTask "json2js", "Concatenating JSON into JS", ->
    data = @data
    grunt.util.async.forEachSeries @files, (f, nextFileObj) ->
      destFile = f.dest
      files = f.src.filter((filepath) ->

        # Warn on and remove invalid source files (if nonull was set).
        unless grunt.file.exists(filepath)
          grunt.log.warn "Source file \"" + filepath + "\" not found."
          false
        else
          true
      )
      json = concatJson(files, data)
      grunt.file.write destFile, json
      grunt.log.write "File \"" + destFile + "\" created."
      return

    return

  return