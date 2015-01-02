assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Destroy Stage", (done) ->
  csrfRes = null
  url = '/stage/destroy'
  stage = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProjectStage (result)->
        stage = result
        done()

  afterEach ->
    stage = null

  it "should be able to delete a stage", (done) ->
    stage._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stage)
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/stage/specifics/#{stage.id}")
      .expect(200)
      .end (err, res)->
        res.body.should.be.empty
        done()

  it "should not be able to delete a stage without csrf", (done) ->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stage)
    .expect(403)
    .end (err, res)->
      done()

  it "should not be able to delete a stage without idProject", (done) ->
    stage._csrf = csrfRes.body._csrf
    delete stage.idProject
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stage)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      done()

  it "should not be able to delete a stage without id", (done) ->
    stage._csrf = csrfRes.body._csrf
    delete stage.id
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stage)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      done()