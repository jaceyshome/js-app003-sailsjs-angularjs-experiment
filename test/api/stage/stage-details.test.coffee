assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify Stage", (done) ->
  csrfRes = null
  url = '/stage/specifics/'
  stage = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProjectStage (result)->
        stage = result
        done()

  afterEach ->
    stage = null

  it "should show stage details", (done)->
    request(sails.hooks.http.app)
    .get(url+stage.id)
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

