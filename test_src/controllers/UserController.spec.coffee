Sails = require("sails")
assert = require("assert")
request = require('supertest')
DBHelper = require('../helpers/db')
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
        database: "palette_test"
        user: "root"
        pass: ""
  , (err, sails) ->
    app = sails
    done err, sails
    return
  return

beforeEach (done)->
  DBHelper.resetDB().then(()->done())

describe "User", (done) ->
  it "should be able to create a user", (done) ->
    request(app.express.app)
    .post('/user/create')
    .send({
      name: 'test'
      email: 'test@test.com'
      password: 'password'
    })
    .expect(200, done)

  return
  done()
return

###
After ALL the tests, lower sails
###
after (done) ->
  DBHelper.resetDB().then(()->
    app.lower done
  )
  return

