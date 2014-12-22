should = require("should")
Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')

describe "Project Update", (done) ->
  csrfRes = null
  url = '/project/update'
  project =
    name: 'test project'
    description: 'test project description'

  before (done)->
    CSRF.get().then (res)->
      csrfRes = res
      done()

  beforeEach (done)->
    _project = JSON.parse(JSON.stringify(project))
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

  it "should be able to update a project with correct info", (done) ->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/project/specifics/'+project.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.description.should.be.eql project.description
        done()
    return

  it "should not be able to update the project without csrf", (done)->
    project.description = 'test description 1'
    request(sails.hooks.http.app)
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
    request(sails.hooks.http.app)
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
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(400)
    .end (err, res)->
        if (err) then throw err
        done()
    return

  it "should not be able to update the project without shortLink", (done)->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    delete project.shortLink
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  it "should not be able to update the project without id", (done)->
    project.description = 'test description 1'
    project._csrf = csrfRes.body._csrf
    delete project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()
    return

  return


