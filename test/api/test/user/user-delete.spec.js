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

describe("User Destroy", function(done) {
  var csrfRes, url, user;
  csrfRes = null;
  url = '/user/destroy';
  user = Config.user;
  before(function(done) {
    return CSRF.get(request, Config.appPath).then(function(res) {
      csrfRes = res;
      return done();
    });
  });
  beforeEach(function(done) {
    var _user;
    _user = JSON.parse(JSON.stringify(Config.user));
    _user._csrf = csrfRes.body._csrf;
    request(Config.appPath).post('/user/create').set('cookie', csrfRes.headers['set-cookie']).send(_user).expect(200).end(function(err, res) {
      if (err) {
        throw err;
      }
      user = res.body;
      return done();
    });
  });
  it("should be able to delete a user", function(done) {
    user._csrf = csrfRes.body._csrf;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).end(function(err, res) {
      should(res.statusCode).be.eql(200);
      should(err).be.empty;
      return done();
    });
  });
  it("should not delete a user without csrf", function(done) {
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).end(function(err, res) {
      should(res.statusCode).be.eql(403);
      should(err).be.empty;
      return done();
    });
  });
  it("should not delete a user with wrong shortLink", function(done) {
    user._csrf = csrfRes.body._csrf;
    user.shortLink = "12sdfs/12321";
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).end(function(err, res) {
      should(res.statusCode).be.eql(500);
      should(err).be.empty;
      return done();
    });
  });
  it("should not delete a user without shortLink", function(done) {
    user._csrf = csrfRes.body._csrf;
    delete user.shortLink;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).end(function(err, res) {
      should(res.statusCode).be.eql(500);
      should(err).be.empty;
      return done();
    });
  });
  it("should not delete a user without id", function(done) {
    user._csrf = csrfRes.body._csrf;
    delete user.id;
    request(Config.appPath).post(url).set('cookie', csrfRes.headers['set-cookie']).send(user).end(function(err, res) {
      should(res.statusCode).be.eql(500);
      should(err).be.empty;
      return done();
    });
  });
});

//# sourceMappingURL=user-delete.spec.js.map
