assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify Task", (done) ->
  csrfRes = null
  url = '/task/specifics'
  project = null
  stage = null
  task = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        data = {}
        data.project = project = result
        CommonHelper.createStage data, (result)->
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
    .get("#{url}/#{task.id}/sg/#{stage.id}/p/#{project.id}")
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

  it "should not show task details without stage id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{task.id}/p/#{project.id}")
    .end (err, res)->
      if (err) then throw err
      res.body.should.be.empty
      res.statusCode.should.not.be.eql 200
      done()

  it "should not show task details without project id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{task.id}/sg/#{stage.id}")
    .end (err, res)->
      if (err) then throw err
      res.body.should.be.empty
      res.statusCode.should.not.be.eql 200
      done()

  it "should not show task details without task id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/sg/#{stage.id}/p/#{project.id}")
    .end (err, res)->
      if (err) then throw err
      res.body.should.be.empty
      res.statusCode.should.not.be.eql 200
      done()