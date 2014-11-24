require('../helpers/upstart')
should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
DBHelper = require('../helpers/db')
CSRF = require('../helpers/csrf')
Config = require('../helpers/config')

describe "Project Update", (done) ->
  csrfRes = null
  url = '/project/update'
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

  it "should be able to update a project with correct info", (done) ->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(Config.appPath)
      .get('/project/specifics/'+project.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.description.should.be.eql project.description
        done()
    return

  it "should not be able to update the project without csrf", (done)->
    project.description = 'test description 1'
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(403)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the project shortLink", (done)->
    project.shortlink = 'xvcxxcv'
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(403)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the project with wrong shortLink", (done)->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    project.shortLink = 'sadfasdfsafa'
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(500)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the project without shortLink", (done)->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    delete project.shortLink
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(500)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the project without id", (done)->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    delete project.id
    request(Config.appPath)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(500)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  return


