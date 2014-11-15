var Promise, db, mysql;

mysql = require('mysql');

db = require('mysql-promise')();

Promise = require('bluebird');

module.exports = (function() {
  var cleanDB, cleanUpDBTables, disableFKConstraint, eableFKConstraint, initStatesTable, migrateDB, service;
  db.configure({
    host: 'localhost',
    database: 'palette_test',
    user: 'root',
    password: ''
  });
  service = {};
  service.resetDB = function() {
    return cleanDB().then(migrateDB);
  };
  service.cleanTable = function(table) {
    return disableFKConstraint().then(function() {
      return db.query("TRUNCATE " + table);
    }).then(eableFKConstraint);
  };
  cleanDB = function() {
    return disableFKConstraint().then(cleanUpDBTables).then(eableFKConstraint);
  };
  disableFKConstraint = function() {
    return db.query("SET FOREIGN_KEY_CHECKS=0;");
  };
  eableFKConstraint = function() {
    return db.query("SET FOREIGN_KEY_CHECKS=1;");
  };
  cleanUpDBTables = function(tables) {
    return new Promise(function(resolve, reject) {
      var truncatedTables;
      truncatedTables = [];
      return db.query("SHOW TABLES").spread(function(tables) {
        return tables.forEach(function(table) {
          return db.query("DELETE FROM " + table.Tables_in_palette_test).then(function() {
            truncatedTables.push(table.Tables_in_palette_test);
            if (truncatedTables.length === tables.length) {
              return resolve();
            }
          });
        });
      })["catch"](reject);
    });
  };
  migrateDB = function() {
    return initStatesTable();
  };
  initStatesTable = function() {
    return db.query("INSERT INTO states (id,name) VALUES(1,'new'),(2,'open'),(3, 'resolved'), (4,'closed');");
  };
  return service;
})();

//# sourceMappingURL=db.js.map
