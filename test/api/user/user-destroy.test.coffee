assert = require("assert")
request = require("supertest")
Promise = require("bluebird")
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "User Destroy", (done) ->
  csrfRes = null
  url = '/user/destroy'
  user = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createUser (result)->
        user = result
        done()

  afterEach ->
    user = null

  it "should be able to delete a user", (done)->
    user._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
      done()

  it "should not delete a user without csrf", (done)->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(403)
    .end (err, res)->
      (err is null).should.be.empty
      done()

  it "should not delete a user with wrong shortLink", (done)->
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
