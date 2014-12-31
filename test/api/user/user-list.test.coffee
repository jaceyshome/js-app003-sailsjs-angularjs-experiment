assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe.skip "(TODO)List User", (done) ->
  csrfRes = null
  url = '/user/update'
  user =
    name: 'test'
    email: 'test@test.com'
    password: 'password'

  before (done)->
    CSRF.get(request, sails.hooks.http.app).then (res)->
      csrfRes = res
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

  it.skip "should only admin can list all users", (done)->

  return


