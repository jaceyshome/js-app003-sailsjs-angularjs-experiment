assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify User", (done) ->
  csrfRes = null
  url = '/user/specify/'
  user = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createUser (result)->
        user = result
        done()

  afterEach ->
    user = null

  it "should show user details", (done)->
    request(sails.hooks.http.app)
    .get(url+user.shortLink)
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.should.have.property 'name'
      res.body.should.have.property 'email'
      res.body.should.have.property 'shortLink'
      res.body.should.not.have.property 'password'
      res.body.name.should.be.eql user.name
      res.body.email.should.be.eql user.email
      user = res.body
      done()

  it "should not show user details without shortLink", (done)->
    request(sails.hooks.http.app)
    .get(url)
    .expect(400)
    .end (err, res)->
      done()
