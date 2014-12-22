should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe "User Update", (done) ->
  csrfRes = null
  url = '/user/update'
  user =
    name: 'test'
    email: 'test@test.com'
    password: 'password'

  before (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      user._csrf = csrfRes.body._csrf
      done()

  beforeEach (done)->
    _user = JSON.parse(JSON.stringify(user))
    _user._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post('/user/create')
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(200)
    .end((err, res)->
      if (err) then throw err
      user = res.body
      done()
    )
    return

  it "should be able to update a user with correct info", (done) ->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = user.password
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/user/specifics/'+user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.email.should.be.eql user.email
        done()
    return

  it "should not be able to update the user without csrf", (done)->
    user.email = 'test1@gmail.com'
    user.password = user.password
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(403)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the user name", (done)->
    originName = user.name
    user.email = 'test1@gmail.com'
    user.name = 'test1'
    user._csrf = csrfRes.body._csrf
    user.password = user.password
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/user/specifics/'+user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.name.should.be.eql originName
        done()
    return

  it "should not be able to update the user with wrong shortLink", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = user.password
    user.shortLink = 'sadfasdfsafa'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(400)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the user without shortLink", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = user.password
    delete user.shortLink
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the user without id", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    delete user.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  return


