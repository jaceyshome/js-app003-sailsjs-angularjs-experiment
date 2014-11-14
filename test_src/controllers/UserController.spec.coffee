Sails = require("sails")
assert = require("assert")
request = require('supertest')
DBHelper = require('../helpers/db')
app = undefined
before (done) ->
  DBHelper.cleanDB()
  @timeout 5000
  Sails.lift
    log:
      level: "error"
    adapters:
      mysql:
        module: "sails-mysql"
        host: "localhost"
        database: "palette_test"
        user: "root"
        pass: ""
  , (err, sails) ->
    app = sails
    done err, sails
    return
  return

describe "User", (done) ->
  DBHelper.cleanDB()
  it "should be able to create a user", (done) ->
    done()
  return
return

###
After ALL the tests, lower sails
###
after (done) ->
  DBHelper.cleanDB()
  # Database.clean...
  app.lower done
  return

