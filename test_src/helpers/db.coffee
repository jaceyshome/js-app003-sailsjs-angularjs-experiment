mysql = require('mysql')
db = require('mysql-promise')()
Promise = require('bluebird')

module.exports =(()->

  db.configure({
    host     : 'localhost'
    database : 'palette_test'
    user     : 'root'
    password : ''
  });

  service = {}

  service.resetDB = ()->
    cleanDB()
    .then(migrateDB)

  service.cleanTable = (table)->
    disableFKConstraint()
    .then(()->db.query("TRUNCATE #{table}"))
    .then(eableFKConstraint)

  cleanDB = ()->
    disableFKConstraint()
    .then(cleanUpDBTables)
    .then(eableFKConstraint)

  disableFKConstraint = ->
    db.query("SET FOREIGN_KEY_CHECKS=0;")

  eableFKConstraint = ->
    db.query("SET FOREIGN_KEY_CHECKS=1;")

  cleanUpDBTables = (tables)->
    new Promise (resolve, reject)->
      truncatedTables = []
      db.query("SHOW TABLES").spread((tables)->
        tables.forEach (table)->
          db.query("DELETE FROM #{table.Tables_in_palette_test}")
          .then ()->
            truncatedTables.push table.Tables_in_palette_test
            if truncatedTables.length is tables.length
              resolve()
      ).catch(reject)

  #----------------------- DB migration ------------------------------
  migrateDB = ->
    initStatesTable()

  initStatesTable = ->
    db.query("INSERT INTO states (id,name)
      VALUES(1,'new'),(2,'open'),(3, 'resolved'), (4,'closed');")

  service

)()