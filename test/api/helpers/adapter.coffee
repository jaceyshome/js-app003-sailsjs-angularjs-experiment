Promise = require('bluebird')
fs = Promise.promisifyAll(require("fs"))

module.exports =(->
  service = {}
  currentType = 'testDiskDb'
  types =

    'testDiskDb':
      config:
        module   : 'sails-disk'
        filePath : '.tmp/testdb'
        inMemory : false
      reset: (cb)->
        files = ['./.tmp/localDiskDb.db', './.tmp/testdbtestDiskDb.db'].map (fileName)->
          fs.unlinkAsync(fileName)
        Promise.settle(files).then (results)->
          console.log "results 0",results[0].isFulfilled()
          console.log "results 1",results[1].isFulfilled()
          cb() if typeof cb is 'function'

    'testMongoDb':
      config:
        module: 'sails-mongo'
        host: 'localhost'
        port: 27017
        user: ''
        password: ''
        database: 'palette_test'
      reset: (cb)->
        clean = require('mongo-clean')
        MongoClient = require('mongodb').MongoClient
        url = "mongodb://localhost:27017/palette_test"
        MongoClient.connect url, { w: 1 }, (err, db)->
          clean(db,cb)

  service.set = (type)->
    currentType = types[type]
    settings = {}
    settings['default'] = type
    settings[type] = currentType.config
    settings

  service.reset = (cb)->
    if typeof currentType.reset is 'function'
      currentType.reset(cb)

  service
)()

