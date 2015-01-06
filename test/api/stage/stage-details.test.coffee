assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify Stage", (done) ->
  csrfRes = null
  url = '/stage/specifics'
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

  it "should show stage details", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{stage.id}/p/#{project.id}")
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.should.have.property 'idProject'
      res.body.should.have.property 'name'
      res.body.should.have.property 'budgetedHours'
      res.body.should.have.property 'createdAt'
      res.body.should.have.property 'updatedAt'
      res.body.should.not.have.property 'projectShortLink'
      if (err) then throw err
      done()

  it "should not show stage details without project id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{stage.id}")
    .end (err, res)->
      if (err) then throw err
      res.body.message.should.be.eql "Bad Request."
      res.statusCode.should.not.be.eql 200
      done()

  it "should not show stage details without stage id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.id}")
    .end (err, res)->
      if (err) then throw err
      res.body.message.should.be.eql "Bad Request."
      res.statusCode.should.not.be.eql 200
      done()