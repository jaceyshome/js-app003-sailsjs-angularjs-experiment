module.exports =
    dev:
      files:
        ".tmp/public/linker/styles/style.css": "assets/src/src.less"
      options:
        sourceMap: true
    prod:
      files:
        ".tmp/public/linker/styles/style.css": "assets/src/src.less"
      options:
        sourceMap: false
        cleancss: true
        compress: true