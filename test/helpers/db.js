var blueBird, mysql;

mysql = require('mysql');

blueBird = require('bluebird');

module.exports = {
  cleanDB: function(callback) {
    var db;
    db = new mysql.createConnection({
      host: 'localhost',
      database: 'palette_test',
      user: 'root',
      password: ''
    });
    db.query("SET FOREIGN_KEY_CHECKS = 0;", function(err, result) {
      return db.query("SHOW TABLES", function(err, tables) {
        return tables.forEach(function(table) {
          return db.query("TRUNCATE users", function(err, result) {
            return console.log("table.Tables_in_palette_test", table.Tables_in_palette_test);
          });
        });
      });
    });
  }
};

//# sourceMappingURL=db.js.map
