Sails = require("sails")
assert = require("assert")
request = require("supertest")
CSRF = require('./helpers/csrf')
adapterHelper = require('./helpers/adapter')
fs = require('fs')

beforeEach (done) ->
  SailsApp = require('sails').Sails
  sails = new SailsApp()
  sails.lift
    log:
      level: "error"
    adapters: adapterHelper.set('testMemoryDb')
    hooks:
      grunt: false
    migrate: 'drop'
  , (err, sails) ->
    done err, sails

afterEach (done)->
  sails.lower ()->
    adapterHelper.reset(done)
