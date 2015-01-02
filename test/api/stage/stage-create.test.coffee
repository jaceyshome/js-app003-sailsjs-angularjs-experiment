Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
moment = require("moment")
CommonHelper = require("../helpers/common")

describe "Create Stage", (done) ->
  csrfRes = null
  url = '/stage/create'
  project = null

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        done()

  afterEach ->
    project = null

  it "should be create one for a project", (done)->
    _project = JSON.parse(JSON.stringify(project))
    data =
      idProject: _project.id
      name: "stage 1"
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .expect(200)
    .end (err, res)->
      res.body.should.have.property 'id'
      res.body.should.have.property 'name'
      res.body.should.have.property 'budgetedHours'
      res.body.should.have.property 'createdAt'
      res.body.should.have.property 'updatedAt'
      res.body.should.not.have.property 'projectShortLink'
      if (err) then throw err
      done()

  it "should not be done without csrf", (done)->
    _project = JSON.parse(JSON.stringify(project))
    data =
      idProject: _project.id
      name: "stage 1"
    request(sails.hooks.http.app)
    .post(url)
    .send(data)
    .expect(403)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should no be done without project id", (done)->
    data =
      name: "stage 1"
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .end (err, res)->
      res.statusCode.should.not.be.equal 200
      if (err) then throw err
      done()
