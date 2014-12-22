Sails = require("sails")
assert = require("assert")
request = require("supertest")
CSRF = require('./helpers/csrf')
fs = require('fs')

before (done) ->
  SailsApp = require('sails').Sails
  sails = new SailsApp()
  sails.lift
    log:
      level: "error"
    adapters:
      'default': 'testDiskDb',
      testMemoryDb:
        module   : 'sails-memory'
      testDiskDb:
        module   : 'sails-disk',
        filePath : '.tmp/testdb'
        inMemory: false
    hooks:
      grunt: false
  , (err, sails) ->
    done err, sails
    return
  return

beforeEach (done)->
  if (fs.existsSync('./.tmp/localDiskDb.db'))
    fs.unlinkSync('./.tmp/localDiskDb.db')
  if (fs.existsSync('./.tmp/testdbtestDiskDb.db'))
    fs.unlinkSync('./.tmp/testdbtestDiskDb.db')
  done()

afterEach (done)->
  if (fs.existsSync('./.tmp/localDiskDb.db'))
    fs.unlinkSync('./.tmp/localDiskDb.db')
  if (fs.existsSync('./.tmp/testdbtestDiskDb.db'))
    fs.unlinkSync('./.tmp/testdbtestDiskDb.db')
  done()


after (done) ->
  if (fs.existsSync('./.tmp/localDiskDb.db'))
    fs.unlinkSync('./.tmp/localDiskDb.db')
  if (fs.existsSync('./.tmp/testdbtestDiskDb.db'))
    fs.unlinkSync('./.tmp/testdbtestDiskDb.db')
  sails.lower(done)
  return

