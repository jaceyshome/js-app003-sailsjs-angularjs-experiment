var DBHelper, Sails, app, assert, request;

Sails = require("sails");

assert = require("assert");

request = require('supertest');

DBHelper = require('../helpers/db');

app = void 0;

before(function(done) {
  this.timeout(5000);
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
  return DBHelper.resetDB().then(function() {
    return done();
  });
});

describe("User", function(done) {
  it("should be able to create a user", function(done) {
    return done();
  });
});

return;


/*
After ALL the tests, lower sails
 */

after(function(done) {
  DBHelper.resetDB();
  app.lower(done);
});

//# sourceMappingURL=UserController.spec.js.map
