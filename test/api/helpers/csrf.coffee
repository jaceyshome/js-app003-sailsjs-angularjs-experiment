Promise = require('bluebird')
request = require("supertest")
config = require('./config')
module.exports = (->
  service = {}
  _csrfRes = null

  service.get = ()->
    new Promise (resolve, reject)->
      if _csrfRes
        resolve _csrfRes
      else
        request(config.appPath).get('/csrfToken').expect(200).end (err, res)->
          if err then reject()
          _csrfRes = res
          resolve _csrfRes

  service.reset = ()->
    _csrfRes = null

  service
)()

