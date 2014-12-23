fs = require('fs')

module.exports =(->
  service = {}
  currentType = 'testDiskDb'
  types =
    'testDiskDb':
      config:
        module   : 'sails-disk'
        filePath : '.tmp/testdb'
        inMemory: false
      reset: (cb)->
        if (fs.existsSync('./.tmp/localDiskDb.db'))
          fs.unlinkSync('./.tmp/localDiskDb.db')
        if (fs.existsSync('./.tmp/testdbtestDiskDb.db'))
          fs.unlinkSync('./.tmp/testdbtestDiskDb.db')
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
    currentType.config

  service.reset = (cb)->
    if typeof currentType.reset is 'function'
      currentType.reset(cb)

  service
)()

