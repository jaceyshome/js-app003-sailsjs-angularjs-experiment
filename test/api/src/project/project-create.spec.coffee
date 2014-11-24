require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "Project Create", (done) ->
  csrfRes = null
  url = '/project/create'
  project = Config.project

  before (done)->
    CSRF.get(request, Config.appPath).then (res)->
      csrfRes = res
      project._csrf = csrfRes.body._csrf
      done()

  it "should be able to create a project with correct info", (done) ->
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(200)
    .end((err, res)->
      if (err) then throw err
      res.body.should.have.property 'id'
      res.body.name.should.be.eql project.name
      res.body.description.should.be.eql project.description
      res.body.should.have.property 'shortLink'
      done()
    )
    return

  it "should not be able to create the project without csrf", (done)->
    _project = JSON.parse(JSON.stringify(project))
    delete _project._csrf
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(403, done)
    return

  it "should not be able to create the project without name", (done)->
    _project = JSON.parse(JSON.stringify(project))
    delete _project.name
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(400, done)
    return

  return


