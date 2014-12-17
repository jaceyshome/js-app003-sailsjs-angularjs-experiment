Sails = require("sails")
assert = require("assert")
request = require("supertest")
DBHelper = require('./db')
CSRF = require('./csrf')
Config = require('./config')

app = undefined

before (done) ->
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
#    sails.localAppURL = ( sails.usingSSL ? 'https' : 'http' ) +
#    '://' + sails.config.host + ':' + sails.config.port + ''
    done err, sails
    return
  return

beforeEach (done)->
  DBHelper.resetDB().then ()->
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

