assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Update Task", (done) ->
  csrfRes = null
  url = '/task/update/'
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
    stages = []
    project = null
    task = null

  it "should be able to update a task for a stage", (done)->
    _task = JSON.parse(JSON.stringify(task))
    _task.name = 'update task test'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_task)
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      if (err) then throw err
      request(sails.hooks.http.app)
      .get("/task/specify/#{_task.id}/sg/#{stages[1].id}/p/#{project.id}")
      .expect(200)
      .end (err,res)->
        res.body.name.should.be.eql _task.name
        done()

  it "should not be able to update a task without csrf", (done)->
    _task = JSON.parse(JSON.stringify(task))
    delete _task.csrf
    _task.name = 'update task test'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_task)
    .expect(403)
    .end (err, res)->
      res.body.should.be.empty
      done()

  it "should not be able to update idProject", (done)->
    _task = JSON.parse(JSON.stringify(task))
    _task.name = 'update task test'
    _task.idProject = 'asdfsa12312t'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()

  it "should not be able to update idStage", (done)->
    _task = JSON.parse(JSON.stringify(task))
    _task.name = 'update task test'
    _task.idStage = 'asdfsa12312t'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()

  it "should not be able to update id", (done)->
    _task = JSON.parse(JSON.stringify(task))
    _task.name = 'update task test'
    _task.id = 'asdfsa12312t'
    request(sails.hooks.http.app)
    .put(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(_task)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      res.body.message.should.be.eql "Bad Request."
      done()