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

describe("User Details", function(done) {
  var csrfRes, url, user;
  csrfRes = null;
  url = '/user/specifics/';
  user = null;
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
  it("should show user details", function(done) {
    request(Config.appPath).get(url + user.shortLink).expect(200).end(function(err, res) {
      res.body.should.have.property('id');
      res.body.should.have.property('name');
      res.body.should.have.property('email');
      res.body.should.have.property('shortLink');
      res.body.should.not.have.property('password');
      res.body.name.should.be.eql(Config.user.name);
      res.body.email.should.be.eql(Config.user.email);
      user = res.body;
      return done();
    });
  });
  it("should not show user details without shortLink", function(done) {
    request(Config.appPath).get(url).expect(400).end(function(err, res) {
      return done();
    });
  });
});

//# sourceMappingURL=user-detail.spec.js.map
