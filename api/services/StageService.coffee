Promise = require("bluebird")
extend = require("extend")

module.exports = (->
  service = {}

  service.getStageOrder = (data, cb)->
    if data.order
      retrun cb(null, data.order)
    else
      Stage.find {
        idProject: data.idProject
      }, (err, results)->
        if err
          return cb(err, null)
        else
          return cb(null, results.length)

  service
)()