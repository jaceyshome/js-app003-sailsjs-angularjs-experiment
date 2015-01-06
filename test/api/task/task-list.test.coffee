assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "List Task", (done) ->
  csrfRes = null
  url = '/task/all'
  stages = []
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        createStageData = {}
        createStageData.project = project = result
        CommonHelper.createStage createStageData, (stage)->
          stage.tasks = []
          data =
            name: "stage 1 task 1"
            idProject: project.id
            idStage: stage.id
          CommonHelper.createTask data, (result)->
            stage.tasks.push result
            data =
              name: "stage 1 task 2"
              idProject: project.id
              idStage: stage.id
            CommonHelper.createTask data, (result)->
              stage.tasks.push result
              stages.push stage
              CommonHelper.createStage createStageData, (stage)->
                stages.push stage
                stage.tasks = []
                data =
                  name: "stage 1 task 1"
                  idProject: project.id
                  idStage: stage.id
                CommonHelper.createTask data, (result)->
                  stage.tasks.push result
                  data =
                    name: "stage 1 task 2"
                    idProject: project.id
                    idStage: stage.id
                  CommonHelper.createTask data, (result)->
                    stage.tasks.push result
                    stages.push stage
                    done()

  afterEach ->
    project = null
    stages = []

  it "should be able to get a list of tasks for a stage", (done) ->
    request(sails.hooks.http.app)
    .get("#{url}/p/#{project.id}/s/#{project.shortLink}/sg/#{stages[0].id}")
    .set('cookie', csrfRes.headers['set-cookie'])
    .expect(200)
    .end (err, res)->
      Object.prototype.toString.call(res.body).should.be.eql '[object Array]'
      results = res.body
      tasks = stages[0].tasks
      for i in [0..results.length-1] by 1
        results[i].should.be.eql tasks[i]
      done()

  it "should not be able to get a list of tasks for a stage without project id", (done) ->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.shortLink}/sg/#{stages[0].id}")
    .set('cookie', csrfRes.headers['set-cookie'])
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.should.be.empty
      done()

  it "should not be able to get a list of tasks for a stage without project shortlink", (done) ->
    request(sails.hooks.http.app)
    .get("#{url}/p/#{project.id}/sg/#{stages[0].id}")
    .set('cookie', csrfRes.headers['set-cookie'])
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.should.be.empty
      done()

  it "should not be able to get a list of tasks for a stage without stage id", (done) ->
    request(sails.hooks.http.app)
    .get("#{url}/sg/#{stages[0].id}")
    .set('cookie', csrfRes.headers['set-cookie'])
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.should.be.empty
      done()