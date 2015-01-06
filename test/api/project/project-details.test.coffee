assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Specify Project", (done) ->
  csrfRes = null
  url = '/project/specifics'
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        done()

  afterEach ->
    project = null

  it "should show project details", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.id}/s/#{project.shortLink}")
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.should.have.property 'shortLink'
      res.body.name.should.be.eql project.name
      res.body.description.should.be.eql project.description
      done()

  it "should not show project details without shortLink", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.id}")
    .end (err, res)->
      res.body.message.should.be.eql 'Bad Request.'
      res.statusCode.should.not.be.eql 200
      done()

  it "should not show project details without id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.shortLink}")
    .end (err, res)->
      res.body.message.should.be.eql 'Bad Request.'
      res.statusCode.should.not.be.eql 200
      done()

  it "should show empty result with wrong id", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/2/s/#{project.shortLink}")
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      done()

  it "should show empty result with wrong shortLink", (done)->
    request(sails.hooks.http.app)
    .get("#{url}/#{project.id}/s/asfas22332sfds")
    .expect(200)
    .end (err, res)->
      res.body.should.be.empty
      done()
