Sails = require("sails")
assert = require("assert")
request = require("supertest")

app = undefined
before (done) ->
  @timeout 5000
  Sails.lift
    log:
      level: "error"
    adapters:
      mysql:
        module: "sails-mysql"
        host: "localhost"
        database: "bdchart_test"
        user: "root"
        pass: ""
  , (err, sails) ->
    app = sails
    done err, sails
    return
  return

#describe "Routes", (done) ->
#  it "GET / should return 200", (done) ->
#    request(app.express.app).get("/").expect 200, done
#    return
#  return

describe "User", (done) ->
  it "should be able to create a user", (done) ->
    User.create
      name: "heeaa12321"
      email: "a@b.c"
      password:'asdasdasd'
    , (err, user) ->
      assert.notEqual user, `undefined`
      done()
      return
    return
  return




###
After ALL the tests, lower sails
###
after (done) ->
  # TODO: Clean up db
  # Database.clean...
  app.lower done
  return
