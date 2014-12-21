should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "User Create", (done) ->
  csrfRes = null
  url = '/user/create'
  user = Config.user

  before (done)->
    CSRF.get(request, sails.hooks.http.app).then (res)->
      csrfRes = res
      user._csrf = csrfRes.body._csrf
      done()

  it "should be able to create a user with correct info", (done) ->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end((err, res)->
      if (err) then throw err
      res.body.should.have.property 'id'
      res.body.should.have.property 'name'
      res.body.should.have.property 'email'
      res.body.should.have.property 'shortLink'
      res.body.should.have.property 'online'
      res.body.should.not.have.property 'password'
      done()
    )
    return

  it "should not create the user with the same name", (done)->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end ()->
      request(sails.hooks.http.app)
      .post(url)
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(user)
      .expect(400)
      .end((err, res)->
        if (err) then throw err
        done()
      )
    return

  it "should not be able to create the user without csrf", (done)->
    _user = JSON.parse(JSON.stringify(user))
    delete _user._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(403, done)
    return

  it "should not be able to create the user without email", (done)->
    _user = JSON.parse(JSON.stringify(user))
    delete _user.email
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400, done)
    return

  it "should not be able to create the user without name", (done)->
    _user = JSON.parse(JSON.stringify(user))
    delete _user.name
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400, done)
    return

  it "should not be able to create the user without password", (done)->
    _user = JSON.parse(JSON.stringify(user))
    delete _user.password
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_user)
    .expect(400, done)
    return

  return


