module.exports =
    dev:
      expand: true
      cwd: "assets"
      src: ["**/*.coffee"]
      dest: ".tmp/public/linker/"
      ext: ".js"
      options:
        sourceMap: true
        bare: true
    prod:
      expand: true
      cwd: "assets"
      src: ["**/*.coffee"]
      dest: ".tmp/public/linker/"
      ext: ".js"
      options:
        sourceMap: true
        bare: true