require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "User Update", (done) ->
  csrfRes = null
  url = '/user/update'
  user = null

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

  it "should be able to update a user with correct info", (done) ->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = Config.user.password
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(Config.appPath)
      .get('/user/specifics/'+user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.email.should.be.eql user.email
        done()
    return

  it "should not be able to update the user without csrf", (done)->
    user.email = 'test1@gmail.com'
    user.password = Config.user.password
    request(Config.appPath)
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
    user.password = Config.user.password
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(Config.appPath)
      .get('/user/specifics/'+user.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.name.should.be.eql originName
        done()
    return

  it "should not be able to update the user with wrong shortLink", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = Config.user.password
    user.shortLink = 'sadfasdfsafa'
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(500)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the user without shortLink", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = Config.user.password
    delete user.shortLink
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(500)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the user without id", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = Config.user.password
    delete user.id
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(500)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the user without password", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(500)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the user with wrong password", (done)->
    user.email = 'test1@gmail.com'
    user._csrf = csrfRes.body._csrf
    user.password = "xcvasasd"
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(user)
    .expect(500)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  return


