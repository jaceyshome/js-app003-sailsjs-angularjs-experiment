assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify Task", (done) ->
  csrfRes = null
  url = '/task/specifics/'
  project = null
  stage = null
  task = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        CommonHelper.createStage project, (result)->
          stage = result
          data =
            idProject: project.id
            idStage: stage.id
          CommonHelper.createTask data, (result)->
            task = result
            done()

  afterEach ->
    project = null
    stage = null

  it "should show task details", (done)->
    request(sails.hooks.http.app)
    .get(url+task.id)
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.should.have.property 'idProject'
      res.body.should.have.property 'idStage'
      res.body.should.have.property 'name'
      res.body.should.have.property 'items'
      res.body.should.have.property 'createdAt'
      res.body.should.have.property 'updatedAt'
      res.body.should.not.have.property 'projectShortLink'
      if (err) then throw err
      done()

