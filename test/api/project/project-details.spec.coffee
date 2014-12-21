require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "Project Details", (done) ->
  csrfRes = null
  url = '/project/specifics/'
  project = null

  before (done)->
    CSRF.get(request, Config.appPath).then (res)->
      csrfRes = res
      done()

  beforeEach (done)->
    _project = JSON.parse(JSON.stringify(Config.project))
    _project._csrf = csrfRes.body._csrf
    request(Config.appPath)
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

  it "should show project details", (done)->
    request(Config.appPath)
    .get(url+project.shortLink)
    .expect(200)
    .end((err, res)->
      res.body.should.have.property 'id'
      res.body.name.should.be.eql project.name
      res.body.description.should.be.eql project.description
      res.body.should.have.property 'shortLink'
      project = res.body
      done()
    )
    return

  it "should not show project details without shortLink", (done)->
    request(Config.appPath)
    .get(url)
    .expect(400)
    .end((err, res)->
      done()
    )
    return

  return


