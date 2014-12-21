should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "User Details", (done) ->
  csrfRes = null
  url = '/user/specifics/'
  user = null

  before (done)->
    CSRF.get(request, sails.hooks.http.app).then (res)->
      csrfRes = res
      done()

  beforeEach (done)->
    _user = JSON.parse(JSON.stringify(Config.user))
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

  it "should show user details", (done)->
    request(sails.hooks.http.app)
    .get(url+user.shortLink)
    .expect(200)
    .end((err, res)->
        res.body.should.have.property 'id'
        res.body.should.have.property 'name'
        res.body.should.have.property 'email'
        res.body.should.have.property 'shortLink'
        res.body.should.not.have.property 'password'
        res.body.name.should.be.eql Config.user.name
        res.body.email.should.be.eql Config.user.email
        user = res.body
        done()
      )
    return

  it "should not show user details without shortLink", (done)->
    request(sails.hooks.http.app)
    .get(url)
    .expect(400)
    .end((err, res)->
      done()
    )
    return

  return


