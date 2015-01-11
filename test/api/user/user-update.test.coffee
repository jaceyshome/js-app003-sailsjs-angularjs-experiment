assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Update User", (done) ->
  csrfRes = null
  url = '/user/update'
  user = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createUser (result)->
        user = result
        done()

  afterEach ->
    user = null

  it "should be able to update a user with correct info", (done) ->
    _user =
      email: 'test1@gmail.com'
      _csrf: csrfRes.body._csrf
      password: CommonHelper.getUserInstance().password
      shortLink: user.shortLink
      id: user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/user/specify/'+user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.email.should.be.eql _user.email
        done()
    return

  it "should not be able to update the user without csrf", (done)->
    _user =
      email: 'test1@gmail.com'
      password: CommonHelper.getUserInstance().password
      shortLink: user.shortLink
      id: user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(403)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the user name", (done)->
    _user =
      name: 'new test name'
      email: 'test1@gmail.com'
      password: CommonHelper.getUserInstance().password
      shortLink: user.shortLink
      _csrf: csrfRes.body._csrf
      id: user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/user/specify/'+_user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.name.should.be.eql user.name
        done()

  it "should not be able to update the user with wrong shortLink", (done)->
    _user =
      email: 'test1@gmail.com'
      password: CommonHelper.getUserInstance().password
      shortLink: 'asfd9123123-lamnasdma,.sc'
      _csrf: csrfRes.body._csrf
      id: user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the user without shortLink", (done)->
    _user =
      email: 'test1@gmail.com'
      password: CommonHelper.getUserInstance().password
      _csrf: csrfRes.body._csrf
      id: user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the user without id", (done)->
    _user =
      name: 'new test name'
      email: 'test1@gmail.com'
      password: CommonHelper.getUserInstance().password
      shortLink: user.shortLink
      _csrf: csrfRes.body._csrf
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()
