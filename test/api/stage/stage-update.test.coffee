assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Update Stage", (done) ->
  csrfRes = null
  url = '/stage/update/'
  stage = null
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        data = {}
        data.project = project = result
        CommonHelper.createStage data, (result)->
          stage = result
          done()

  afterEach ->
    stage = null
    project = null

  it "should be able to update a stage for a project", (done) ->
    _stage = JSON.parse(JSON.stringify(stage))
    _stage.name = 'update stage'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_stage)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get("/stage/specifics/#{stage.id}/p/#{project.id}")
      .expect(200)
      .end (err,res)->
        res.body.name.should.be.eql _stage.name
        done()

  it "should not be able to update idProject", (done)->
    _stage = JSON.parse(JSON.stringify(stage))
    _stage.name = 'update stage'
    _stage.idProject = 2
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_stage)
    .expect(400)
    .end (err, res)->
      res.body.message.should.be.eql "Bad Request."
      done()

  it "should not be able to update id"