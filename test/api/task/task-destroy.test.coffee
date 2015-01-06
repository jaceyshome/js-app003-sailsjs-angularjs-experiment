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

  it "should be able to delete a task"

  it "should be able to delete a task with related taskLogs"

  it "should not be able to delete a task without csrf"

  it "should not be able to delete a task without idProject"

  it "should not be able to delete a task without idStage"

  it "should not be able to delete a task without id"
