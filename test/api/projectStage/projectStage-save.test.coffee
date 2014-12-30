Sails = require("sails")
assert = require("assert")
request = require("supertest")
Promise = require('bluebird')
CSRF = require('../helpers/csrf')
moment = require("moment")

describe "Project Stage Save", (done) ->
  csrfRes = null
  url = '/project/create'
  project =
    name: "test project"
    description: "test project description"
    stages: [
      {
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
      },
      {
        "title": "stage 2",
        "tasks": [
          {
            "title": "task 2.1",
            "items": [
              {name:"task 2.1 item 1"}
              {name:"task 2.1 item 2"}
            ]
          },
          {
            "title": "task 2.2",
            "items": [
              {name:"task 2.2 item 1"}
              {name:"task 2.2 item 2"}
            ]
          }
        ]
      },
    ]

  beforeEach (done)->
    CSRF.get().then (_csrfRes)->
      csrfRes = _csrfRes
      project._csrf = csrfRes.body._csrf
      done()

  it "should exists", ->
    (ProjectStage.hasOwnProperty 'save').should.be.true

  it "should save stage of a project", (done)->

    done()


  it "should update stage of a project"

