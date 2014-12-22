should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe.only "User Destroy", (done) ->
  csrfRes = null
  url = '/user/destroy'
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

  it "should be able to delete a user", (done) ->
    user._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .end((err, res)->
      should(res.statusCode).be.eql 200
      should(err).be.empty
      done()
    )
    return

  it "should not delete a user without csrf", (done)->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .end((err, res)->
        should(res.statusCode).be.eql 403
        should(err).be.empty
        done()
      )
    return

  it "should not delete a user with wrong shortLink", (done)->
    user._csrf = csrfRes.body._csrf
    user.shortLink = "12sdfs/12321"
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  it "should not delete a user without shortLink", (done)->
    user._csrf = csrfRes.body._csrf
    delete user.shortLink
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  it "should not delete a user without id", (done)->
    user._csrf = csrfRes.body._csrf
    delete user.id
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  return


