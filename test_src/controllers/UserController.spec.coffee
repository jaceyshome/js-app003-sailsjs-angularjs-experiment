Sails = require("sails")
assert = require("assert")
request = require("supertest")
DBHelper = require('../helpers/db')
app = undefined
reqApp = undefined

before (done) ->
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
    reqApp = app.express.app
    done err, sails
    return
  return

beforeEach (done)->
  DBHelper.resetDB().then(()->done())

describe "Create User", (done) ->
  it "should be able to create a user with correct info", (done) ->
    request(reqApp)
    .post('/user/create')
    .send({
      name: 'test'
      email: 'test@test.com'
      password: 'password'
    })
    .expect(200)
    .expect((res)->
      unless ('id' of res.body) then return "response missing id"
      unless ('name' of res.body) then return "response missing name"
      unless ('email' of res.body) then return "response missing email"
      unless ('shortLink' of res.body) then return "response missing shortLink"
      unless ('online' of res.body) then return "response missing online"
      if ('password' of res.body) then return "response should not have password"
    ).end(done)
    return

  it "should not be able to create the same user", (done)->
    @timeout 5000
    request(reqApp)
    .post('/user/create')
    .send({
      name: 'test'
      email: 'test@test.com'
      password: 'password'
    })
    .expect(200)
    .end(()->
      request(reqApp)
      .post('/user/create')
      .send({
        name: 'test'
        email: 'test@test.com'
        password: 'password'
      })
      .expect(500)
      .end(done)
    )
    return

  return

describe.only "Update user", (done)->
  it "should update user with required field", (done)->
    @timeout 5000
    request(reqApp)
    .request(reqApp)
    .put("/user/update")

###
After ALL the tests, lower sails
###

after (done) ->
  DBHelper.resetDB().then(()->
    app.lower done
  )
  return

