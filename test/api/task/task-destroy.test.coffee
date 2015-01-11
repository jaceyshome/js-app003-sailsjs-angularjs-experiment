assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Destroy Task", (done) ->
  csrfRes = null
  url = '/task/destroy'
  stages = []
  project = null
  task = null

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
              createStageData.name = "stage 2"
              CommonHelper.createStage createStageData, (stage)->
                stages.push stage
                stage.tasks = []
                data =
                  name: "stage 2 task 1"
                  idProject: project.id
                  idStage: stage.id
                CommonHelper.createTask data, (result)->
                  stage.tasks.push result
                  task = result
                  data =
                    name: "stage 2 task 2"
                    idProject: project.id
                    idStage: stage.id
                  CommonHelper.createTask data, (result)->
                    stage.tasks.push result
                    stages.push stage
                    done()

  afterEach ->
    project = null
    stages = []
    task = null

  it "should be able to delete a task", (done)->
    task._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(task)
    .expect(200)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/task/specify/#{task.id}/sg/#{stages[1].id}/p/#{project.id}")
      .expect(200)
      .end (err, res)->
        res.body.should.be.empty
        done()


  it "should be able to delete a task with related taskLogs"

  it "should not be able to delete a task without csrf", (done)->
    delete task._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(task)
    .expect(403)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.should.be.empty
      done()

  it "should not be able to delete a task without idProject", (done)->
    delete task.idProject
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()

  it "should not be able to delete a task without idStage", (done)->
    delete task.idStage
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()


  it "should not be able to delete a task without id", (done)->
    delete task.id
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()
