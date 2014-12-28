Promise = require('bluebird')
request = require("supertest")
config = require('./config')
module.exports = (->
  service = {}
  _csrfRes = null

  service.get = ()->
    new Promise (resolve, reject)->
      request(config.appPath).get('/csrfToken').expect(200).end (err, res)->
        if err then reject()
        _csrfRes = res
        resolve _csrfRes
  service
)()

