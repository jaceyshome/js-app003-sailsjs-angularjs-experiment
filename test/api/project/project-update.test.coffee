assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Update Project", (done) ->
  csrfRes = null
  url = '/project/update'
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        done()

  afterEach ->
    project = null

  it "should be able to update a project with correct info", (done) ->
    _project =
      name: project.name
      description: 'test description 1'
      _csrf: csrfRes.body._csrf
      shortLink: project.shortLink
      id: project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get('/project/specifics/'+project.shortLink)
      .expect(200)
      .end (err,res)->
        res.body.description.should.be.eql _project.description
        done()

  it "should not be able to update the project without csrf", (done)->
    _project =
      name: project.name
      description: 'test description 1'
      shortLink: project.shortLink
      id: project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(403)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the project shortLink", (done)->
    _project =
      name: project.name
      description: 'test description 1'
      shortLink: "asdfsafas12431231"
      _csrf: csrfRes.body._csrf
      id: project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the project with wrong shortLink", (done)->
    _project =
      name: project.name
      description: 'test description 1'
      shortLink: "asdfsafas12431231"
      _csrf: csrfRes.body._csrf
      id: project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the project without shortLink", (done)->
    _project =
      name: project.name
      description: 'test description 1'
      _csrf: csrfRes.body._csrf
      id: project.id
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be able to update the project without id", (done)->
    _project =
      name: project.name
      description: 'test description 1'
      _csrf: csrfRes.body._csrf
      shortLink: project.shortLink
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_project)
    .expect(400)
    .end (err, res)->
      if (err) then throw err
      done()

