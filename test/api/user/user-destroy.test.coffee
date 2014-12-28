Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe.only "User Destroy", (done) ->
  csrfRes = null
  url = '/user/destroy'
  createTestUser = (cb)->
    user =
      name: 'test'
      email: 'test@test.com'
      password: 'password'
    _user = JSON.parse(JSON.stringify(user))
    _user._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post('/user/create')
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(200)
    .end (err, res)->
      if (err) then throw err
      if cb then cb(res.body)

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      done()

  it "should be able to delete a user", (done) ->
    createTestUser (user)->
      user._csrf = csrfRes.body._csrf
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(200)
      .end (err, res)->
        err.should.be.empty
        done()

  it "should not delete a user without csrf", (done)->
    createTestUser (user)->
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(403)
      .end (err, res)->
        (err is null).should.be.empty
        done()

  it "should not delete a user with wrong shortLink", (done)->
    createTestUser (user)->
      user._csrf = csrfRes.body._csrf
      user.shortLink = "12sdfs/12321"
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(400)
      .end (err, res)->
        (err is null).should.be.empty
        done()

  it "should not delete a user without shortLink", (done)->
    createTestUser (user)->
      user._csrf = csrfRes.body._csrf
      delete user.shortLink
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(400)
      .end (err, res)->
        (err is null).should.be.empty
        done()

  it "should not delete a user without id", (done)->
    createTestUser (user)->
      user._csrf = csrfRes.body._csrf
      delete user.id
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(400)
      .end (err, res)->
        (err is null).should.be.empty
        done()
