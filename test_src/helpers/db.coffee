mysql = require('mysql')
db = require('mysql-promise')()
module.exports =(()->

  db.configure({
    host     : 'localhost'
    database : 'palette_test'
    user     : 'root'
    password : ''
  });

  disableFKConstraint = ->
    db.query("SET FOREIGN_KEY_CHECKS = 0;")

  eableFKConstraint = ->
    db.query("SET FOREIGN_KEY_CHECKS = 1;")

  cleanUpDBTables = (tables)->
    db.query("SHOW TABLES").spread((tables)->
      tables.forEach (table)->
        db.query("TRUNCATE #{table.Tables_in_palette_test}")
        .then (result)->
          console.log "table: ", table.Tables_in_palette_test
    )

  service = {}

  service.cleanDB = ()->
    disableFKConstraint()
    .then(cleanUpDBTables)
    .then(eableFKConstraint)

  service

)()