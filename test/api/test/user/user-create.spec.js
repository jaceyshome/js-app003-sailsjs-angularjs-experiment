var CSRF, Config, DBHelper, Promise, Sails, assert, request, should;

require('../helpers/upstart');

should = require("should");

Sails = require("sails");

assert = require("assert");

request = require("supertest");

Promise = require('bluebird');

DBHelper = require('../helpers/db');

CSRF = require('../helpers/csrf');

Config = require('../helpers/config');

describe("User Create", function(done) {
  var csrfRes, url, user;
  csrfRes = null;
  url = '/user/create';
  user = Config.user;
  before(function(done) {
    return CSRF.get(request, Config.appPath).then(function(res) {
      csrfRes = res;
      user._csrf = csrfRes.body._csrf;
      return done();
    });
  });
  it("should be able to create a user with correct info", function(done) {
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(200).end(function(err, res) {
      if (err) {
        throw err;
      }
      res.body.should.have.property('id');
      res.body.should.have.property('name');
      res.body.should.have.property('email');
      res.body.should.have.property('shortLink');
      res.body.should.have.property('online');
      res.body.should.not.have.property('password');
      return done();
    });
  });
  it("should not create the user with the same name", function(done) {
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(200).end(function() {
      return request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(400).end(function(err, res) {
        if (err) {
          throw err;
        }
        return done();
      });
    });
  });
  it("should not be able to create the user without csrf", function(done) {
    var _user;
    _user = JSON.parse(JSON.stringify(user));
    delete _user._csrf;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(_user).expect(403, done);
  });
  it("should not be able to create the user without email", function(done) {
    var _user;
    _user = JSON.parse(JSON.stringify(user));
    delete _user.email;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(_user).expect(400, done);
  });
  it("should not be able to create the user without name", function(done) {
    var _user;
    _user = JSON.parse(JSON.stringify(user));
    delete _user.name;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(_user).expect(400, done);
  });
  it("should not be able to create the user without password", function(done) {
    var _user;
    _user = JSON.parse(JSON.stringify(user));
    delete _user.password;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(_user).expect(400, done);
  });
});

//# sourceMappingURL=user-create.spec.js.map
