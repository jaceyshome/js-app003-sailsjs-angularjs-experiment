assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Destroy Project", (done) ->
  csrfRes = null
  url = '/project/destroy'
  stages = []
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        data = {}
        data.project = result
        CommonHelper.createStage data, (stage)->
          stages.push stage
          CommonHelper.createStage data, (stage)->
            stages.push stage
            done()

  afterEach ->
    project = null
    stages = []

  it "should be able to delete a project", (done) ->
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/project/specifics/#{project.id}/s/#{project.shortLink}")
      .expect(200)
      .end (err, res)->
        res.body.should.be.empty
        done()

  it "should not delete a project without csrf", (done)->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      done()

  it "should not delete a project with wrong shortLink", (done)->
    project._csrf = csrfRes.body._csrf
    project.shortLink = "12sdfs/12321"
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      done()

  it "should not delete a project without shortLink", (done)->
    project._csrf = csrfRes.body._csrf
    delete project.shortLink
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      done()

  it "should not delete a project without id", (done)->
    project._csrf = csrfRes.body._csrf
    delete project.id
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      done()
