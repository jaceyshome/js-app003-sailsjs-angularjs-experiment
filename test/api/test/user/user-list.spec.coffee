require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "(TODO) User List", (done) ->
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

  it.skip "should only admin can list all users", (done)->

  return


