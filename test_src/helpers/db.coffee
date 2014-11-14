mysql = require('mysql')
blueBird = require('bluebird')
module.exports =
  cleanDB : (callback)->
    db = new mysql.createConnection({
      host     : 'localhost'
      database : 'palette_test'
      user     : 'root'
      password : ''
    })

    db.query "SET FOREIGN_KEY_CHECKS = 0;", (err, result)->
      db.query "SHOW TABLES", (err, tables)->
        tables.forEach (table)->
          db.query "TRUNCATE #{table.Tables_in_palette_test}", (err, result)->
            console.log "table.Tables_in_palette_test", table.Tables_in_palette_test
#        db.end()

    return

