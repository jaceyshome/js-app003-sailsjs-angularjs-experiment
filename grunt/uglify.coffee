module.exports =
    dist:
      src: ['.tmp/public/concat/production.js'],
      dest: '.tmp/public/min/production-<%= packageVersion %>.js'
    options :
      mangle : false