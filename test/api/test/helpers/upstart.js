var CSRF, Config, DBHelper, Sails, app, assert, request;

Sails = require("sails");

assert = require("assert");

request = require("supertest");

DBHelper = require('./db');

CSRF = require('./csrf');

Config = require('./config');

app = void 0;

before(function(done) {
  Sails.lift({
    log: {
      level: "error"
    },
    adapters: {
      mysql: {
        module: "sails-mysql",
        host: "localhost",
        database: "palette_test",
        user: "root",
        pass: ""
      }
    }
  }, function(err, sails) {
    app = sails;
    done(err, sails);
  });
});

beforeEach(function(done) {
  DBHelper.resetDB().then(function() {
    return done();
  });
});


/*
After ALL the tests, lower sails
 */

after(function(done) {
  DBHelper.resetDB().then(function() {
    return app.lower(done);
  });
});

//# sourceMappingURL=upstart.js.map
