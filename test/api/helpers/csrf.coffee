Promise = require('bluebird')
request = require("supertest")
config = require('./config')
module.exports = (->
  service = {}
  _csrf = null

  service.get = ()->
    new Promise (resolve, reject)->
      unless _csrf
        request(config.appPath).get('/csrfToken').expect(200).end (err, res)->
          if err then reject()
          _csrf = res.body._csrf
          resolve _csrf
      else
        resolve _csrf
  service
)()

