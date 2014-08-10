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
    hooks:
      grunt:false
  , (err, sails) ->
    app = sails
    sails.localAppURL = ( sails.usingSSL ? 'https' : 'http' ) +
    '://' + sails.config.host + ':' + sails.config.port + ''
    done err, sails
    return
  return

###
After ALL the tests, lower sails
###
after (done) ->
  console.log('\nLowering sails')
  # TODO: Clean up db
  # Database.clean...
  app.lower done
  return
