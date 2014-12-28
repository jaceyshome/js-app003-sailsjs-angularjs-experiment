assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
CommonHelper = require("../helpers/common")

describe "Project Details", (done) ->
  csrfRes = null
  url = '/project/specifics/'
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
    .get(url+project.shortLink)
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.name.should.be.eql project.name
      res.body.description.should.be.eql project.description
      res.body.should.have.property 'shortLink'
      done()

  it "should not show project details without shortLink", (done)->
    request(sails.hooks.http.app)
    .get(url)
    .expect(400)
    .end (err, res)->
      done()


