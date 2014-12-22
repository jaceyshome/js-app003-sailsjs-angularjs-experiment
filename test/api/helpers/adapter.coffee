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
      reset: ()->
        if (fs.existsSync('./.tmp/localDiskDb.db'))
          fs.unlinkSync('./.tmp/localDiskDb.db')
        if (fs.existsSync('./.tmp/testdbtestDiskDb.db'))
          fs.unlinkSync('./.tmp/testdbtestDiskDb.db')
    'testMongoDb':
      config:
        module: 'sails-mongo'
        host: 'localhost'
        port: 27017
        user: ''
        password: ''
        database: 'palette_test'
      reset: ()->

  service.set = (type)->
    currentType = types[type]
    console.log "currentType.config", currentType.config
    currentType.config

  service.reset = ()->
    if typeof currentType.reset is 'function'
      currentType.reset()

  service
)()

