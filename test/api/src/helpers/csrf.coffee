Promise = require('bluebird')
module.exports =
  get : (request, reqApp)->
    new Promise (resolve, reject)->
      request(reqApp).get('/csrfToken').expect(200).end (err, res)->
        if err then reject()
        resolve res

