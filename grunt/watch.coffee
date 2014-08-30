module.exports =
    api:
      files: ["api/**/*"]
    assets:
      files: ["assets/src/**/*"]
      tasks: [
        "watchAssets"
        "linkAssets"
      ]