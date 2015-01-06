assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Destroy Stage", (done) ->
  csrfRes = null
  url = '/stage/destroy'
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

  it "should be able to delete a stage", (done) ->
    stages[0]._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stages[0])
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/stage/specifics/#{stages[0].id}/p/#{project.id}")
      .expect(200)
      .end (err, res)->
        res.body.should.be.empty
        done()

  it "should be able to delete a stage with related tasks", (done)->
    stages[0]._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stages[0])
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/task/all/p/#{project.id}/s/#{project.shortLink}/sg/#{stages[0].id}")
      .end (err, res)->
        res.body.message.should.be.eql "Bad Request."
        res.statusCode.should.not.be.eql 200
        done()

  it "should not be able to delete a stage without csrf", (done) ->
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stages[0])
    .expect(403)
    .end (err, res)->
      res.body.should.be.empty
      done()

  it "should not be able to delete a stage without idProject", (done) ->
    stages[0]._csrf = csrfRes.body._csrf
    delete stages[0].idProject
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stages[0])
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()

  it "should not be able to delete a stage without id", (done) ->
    stages[0]._csrf = csrfRes.body._csrf
    delete stages[0].id
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(stages[0])
    .end (err, res)->
      res.body.message.should.be.eql "Bad Request."
      res.statusCode.should.not.be.eql 200
      done()