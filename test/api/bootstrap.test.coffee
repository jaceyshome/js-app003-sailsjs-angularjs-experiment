Sails = require("sails")
assert = require("assert")
request = require("supertest")
CSRF = require('./helpers/csrf')
adapterHelper = require('./helpers/adapter')
fs = require('fs')

before (done) ->
  SailsApp = require('sails').Sails
  sails = new SailsApp()
  sails.lift
    log:
      level: "error"
    adapters:
      'default': 'testDiskDb'
      testDiskDb: adapterHelper.set('testDiskDb')
    hooks:
      grunt: false
  , (err, sails) ->
    done err, sails

afterEach (done)->
  adapterHelper.reset()
  done()

after (done) ->
  adapterHelper.reset()
  sails.lower(done)

