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

describe("User Update", function(done) {
  var csrfRes, url, user;
  csrfRes = null;
  url = '/user/update';
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
  it("should be able to update a user with correct info", function(done) {
    user.email = 'test1@gmail.com';
    user._csrf = csrfRes.body._csrf;
    user.password = Config.user.password;
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(200).end(function(err, res) {
      res.body.should.be.empty;
      if (err) {
        throw err;
      }
      return request(Config.appPath).get('/user/specifics/' + user.shortLink).expect(200).end(function(err, res) {
        res.body.email.should.be.eql(user.email);
        return done();
      });
    });
  });
  it("should not be able to update the user without csrf", function(done) {
    user.email = 'test1@gmail.com';
    user.password = Config.user.password;
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(403).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
  it("should not be able to update the user name", function(done) {
    var originName;
    originName = user.name;
    user.email = 'test1@gmail.com';
    user.name = 'test1';
    user._csrf = csrfRes.body._csrf;
    user.password = Config.user.password;
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(200).end(function(err, res) {
      res.body.should.be.empty;
      if (err) {
        throw err;
      }
      return request(Config.appPath).get('/user/specifics/' + user.shortLink).expect(200).end(function(err, res) {
        res.body.name.should.be.eql(originName);
        return done();
      });
    });
  });
  it("should not be able to update the user with wrong shortLink", function(done) {
    user.email = 'test1@gmail.com';
    user._csrf = csrfRes.body._csrf;
    user.password = Config.user.password;
    user.shortLink = 'sadfasdfsafa';
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(400).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
  it("should not be able to update the user without shortLink", function(done) {
    user.email = 'test1@gmail.com';
    user._csrf = csrfRes.body._csrf;
    user.password = Config.user.password;
    delete user.shortLink;
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(400).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
  it("should not be able to update the user without id", function(done) {
    user.email = 'test1@gmail.com';
    user._csrf = csrfRes.body._csrf;
    user.password = Config.user.password;
    delete user.id;
    request(Config.appPath).put(url).set('cookie', csrfRes.headers['set-cookie']).send(user).expect(400).end(function(err, res) {
      if (err) {
        throw err;
      }
      return done();
    });
  });
});

//# sourceMappingURL=user-update.spec.js.map
