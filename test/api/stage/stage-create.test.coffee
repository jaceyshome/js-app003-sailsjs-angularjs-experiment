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
  stage =
    "title": "stage 1",
    "tasks": [
      {
        "title": "task 1.1",
        "items": [
          {name:"task 1.1 item 1"}
          {name:"task 1.1 item 2"}
          {name:"task 1.1 item 3"}
        ]
      },
      {
        "title": "task 1.2",
        "items": [
          {name:"task 1.2 item 1"}
          {name:"task 1.2 item 2"}
          {name:"task 1.2 item 3"}
        ]
      }
    ]

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      CommonHelper.createProject (result)->
        project = result
        done()

  afterEach ->
    project = null

  it.only "should be create one for a project", (done)->
    _project = JSON.parse(JSON.stringify(project))
    data =
      projectId: _project.id
      projectShortLink: _project.shortLink
      name: "stage 1"
      _csrf:  csrfRes.body._csrf
    request(sails.hooks.http.app)
    .post(url)
    .set('cookie', csrfRes.headers['set-cookie'])
    .send(data)
    .expect(200)
    .end (err, res)->
      if (err) then throw err
      done()

  it "should not be done without csrf", (done)->
    done()

  it "should update a single stage"
