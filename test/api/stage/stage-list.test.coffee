assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "List Stage", (done) ->
  csrfRes = null
  url = '/stage/all/p'
  stages = []
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        data = {}
        data.project = project = result
        CommonHelper.createStage data, (stage)->
          stages.push stage
          CommonHelper.createStage data, (stage)->
            stages.push stage
            done()

  afterEach ->
    project = null
    stages = []

  it "should be able to get a list of stages for a project", (done) ->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.id}/s/#{project.shortLink}")
    .set('cookie', csrfRes.headers['set-cookie'])
    .expect(200)
    .end (err, res)->
      Object.prototype.toString.call(res.body).should.be.eql '[object Array]'
      results = res.body
      for i in [0..results.length-1] by 1
        results[i].name.should.be.eql stages[i].name
        results[i].id.should.be.eql stages[i].id
        results[i].idProject.should.be.eql stages[i].idProject
      done()

  it "should not be able to get a list of stages for a project without project id"

  it "should not be able to get a list of stages for a project without project shortLink"
