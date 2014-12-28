assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Project Destroy", (done) ->
  csrfRes = null
  url = '/project/destroy'
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        done()

  afterEach ->
    project = null

  it "should be able to delete a project", (done) ->
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
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
