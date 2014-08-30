module.exports =
    watch:
      tasks: ["watch:less"
              "watch:coffee"
              "watch:jade"]
      options:
        logConcurrentOutput: true
    test:
      tasks: ["watch:less"
              "watch:coffee"
              "watch:jade"]
      options:
        logConcurrentOutput: true