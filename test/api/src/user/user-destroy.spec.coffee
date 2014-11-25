require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "User Destroy", (done) ->
  csrfRes = null
  url = '/user/destroy'
  user = Config.user

  before (done)->
    CSRF.get(request, Config.appPath).then (res)->
      csrfRes = res
      done()

  beforeEach (done)->
    _user = JSON.parse(JSON.stringify(Config.user))
    _user._csrf = csrfRes.body._csrf
    request(Config.appPath)
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
    request(Config.appPath)
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
    request(Config.appPath)
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
    request(Config.appPath)
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
    request(Config.appPath)
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
    request(Config.appPath)
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


