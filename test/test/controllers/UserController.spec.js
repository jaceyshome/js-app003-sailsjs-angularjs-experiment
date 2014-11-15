var DBHelper, Sails, app, assert, reqApp, request;

Sails = require("sails");

assert = require("assert");

request = require("supertest");

DBHelper = require('../helpers/db');

app = void 0;

reqApp = void 0;

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
    reqApp = app.express.app;
    done(err, sails);
  });
});

beforeEach(function(done) {
  return DBHelper.resetDB().then(function() {
    return done();
  });
});

describe("Create User", function(done) {
  it("should be able to create a user with correct info", function(done) {
    request(reqApp).post('/user/create').send({
      name: 'test',
      email: 'test@test.com',
      password: 'password'
    }).expect(200).expect(function(res) {
      if (!('id' in res.body)) {
        return "response missing id";
      }
      if (!('name' in res.body)) {
        return "response missing name";
      }
      if (!('email' in res.body)) {
        return "response missing email";
      }
      if (!('shortLink' in res.body)) {
        return "response missing shortLink";
      }
      if (!('online' in res.body)) {
        return "response missing online";
      }
      if ('password' in res.body) {
        return "response should not have password";
      }
    }).end(done);
  });
  it("should not be able to create the same user", function(done) {
    this.timeout(5000);
    request(reqApp).post('/user/create').send({
      name: 'test',
      email: 'test@test.com',
      password: 'password'
    }).expect(200).end(function() {
      return request(reqApp).post('/user/create').send({
        name: 'test',
        email: 'test@test.com',
        password: 'password'
      }).expect(500).end(done);
    });
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

//# sourceMappingURL=UserController.spec.js.map
