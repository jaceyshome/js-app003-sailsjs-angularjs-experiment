Promise = require('bluebird')
request = require("supertest")
config = require('./config')
module.exports = (->
  service = {}
  _csrfRes = null

  service.get = ()->
    new Promise (resolve, reject)->
      unless _csrfRes
        request(config.appPath).get('/csrfToken').expect(200).end (err, res)->
          if err then reject()
          _csrfRes = res
          resolve _csrfRes
      else
        resolve _csrfRes
  service
)()

