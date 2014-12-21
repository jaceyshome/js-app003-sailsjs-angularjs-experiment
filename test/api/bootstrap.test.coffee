Sails = require("sails")
assert = require("assert")
request = require("supertest")
CSRF = require('./helpers/csrf')

before (done) ->
  SailsApp = require('sails').Sails
  sails = new SailsApp()
  sails.lift
    log:
      level: "error"
  , (err, sails) ->
    done err, sails
    return
  return

beforeEach (done)->
  return

after (done) ->
  return

