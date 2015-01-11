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

  it "should be able to delete a project", (done) ->
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/project/specify/#{project.id}/s/#{project.shortLink}")
      .expect(200)
      .end (err, res)->
        res.body.should.be.empty
        done()

  it "should be able to delete a project and related stages", (done)->
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/stage/all/#{project.id}/s/#{project.shortLink}")
      .end (err, res)->
        res.body.should.be.empty
        res.statusCode.should.not.be.eql 200
        done()

  it "should be able to delete a project and related tasks",(done)->
    project._csrf = csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(project)
    .end (err, res)->
      (err is null).should.be.empty
      request(sails.hooks.http.app)
      .get("/task/all/p/#{project.id}/s/#{project.shortLink}/sg/#{stages[0].id}")
      .end (err, res)->
        res.body.message.should.be.eql "Bad Request."
        res.statusCode.should.not.be.eql 200
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
