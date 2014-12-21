should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe "(TODO) Project List", (done) ->
  csrfRes = null
  url = '/project/update'
  project = null

  before (done)->
    CSRF.get(request, sails.hooks.http.app).then (res)->
      csrfRes = res
      done()

  beforeEach (done)->
    _project = JSON.parse(JSON.stringify(Config.project))
    _project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post('/project/create')
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(200)
    .end((err, res)->
      if (err) then throw err
      project = res.body
      done()
    )
    return

  it.skip "should only admin can list all users", (done)->

  return


