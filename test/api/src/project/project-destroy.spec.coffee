require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "Project Destroy", (done) ->
  csrfRes = null
  url = '/project/destroy'
  project = Config.project

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

  it "should be able to delete a project", (done) ->
    project._csrf = csrfRes.body._csrf
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end((err, res)->
      should(res.statusCode).be.eql 200
      should(err).be.empty
      done()
    )
    return

  it "should not delete a project without csrf", (done)->
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end((err, res)->
        should(res.statusCode).be.eql 403
        should(err).be.empty
        done()
      )
    return

  it "should not delete a project with wrong shortLink", (done)->
    project._csrf = csrfRes.body._csrf
    project.shortLink = "12sdfs/12321"
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  it "should not delete a project without shortLink", (done)->
    project._csrf = csrfRes.body._csrf
    delete project.shortLink
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  it "should not delete a project without id", (done)->
    project._csrf = csrfRes.body._csrf
    delete project.id
    request(Config.appPath)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end((err, res)->
        should(res.statusCode).be.eql 400
        should(err).be.empty
        done()
      )
    return

  return


