module.exports =
    dev:
      expand: true
      cwd: "assets/src"
      src: ["**/*.jade"]
      dest: "templates/"
      ext: ".html"
      options:
        pretty: true

    prod:
      expand: true
      cwd: "assets/src"
      src: ["**/*.jade"]
      dest: "templates/"
      ext: ".html"
      options:
        pretty: false
        data:
          deploy: true