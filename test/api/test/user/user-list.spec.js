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

describe("(TODO) User List", function(done) {
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
  it.skip("should only admin can list all users", function(done) {});
});

//# sourceMappingURL=user-list.spec.js.map
