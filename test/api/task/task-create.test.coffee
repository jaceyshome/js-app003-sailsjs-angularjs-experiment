Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
moment = require("moment")
CommonHelper = require("../helpers/common")

describe "Create Task", (done) ->
  csrfRes = null
  url = '/task/create'
  project = null
  stage = null
  task =
    name: "task 1.1"
    items: [
      {name:"task 1.1 item 1"}
      {name:"task 1.1 item 2"}
      {name:"task 1.1 item 3"}
    ]

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        CommonHelper.createStage project, (result)->
          stage = result
          done()

  afterEach ->
    project = null
    stage = null

  it "should create one for a stage", (done)->
    _task = JSON.parse(JSON.stringify(task))
    data =
      idProject: project.id
      idStage: stage.id
      name: _task.name
      items: _task.items
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
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

  it "should not be done without csrf", (done)->
    _task = JSON.parse(JSON.stringify(task))
    data =
      idProject: project.id
      idStage: stage.id
      name: _task.name
      items: _task.items
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .expect(403)
    .end (err, res)->
      done()

  it "should not be done without idProject", (done)->
    _task = JSON.parse(JSON.stringify(task))
    data =
      idStage: stage.id
      name: _task.name
      items: _task.items
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      done()

  it "should not be done without idStage", (done)->
    _task = JSON.parse(JSON.stringify(task))
    data =
      idProject: project.id
      name: _task.name
      items: _task.items
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .end (err, res)->
      res.statusCode.should.not.be.eql 200
      done()
