Promise = require("bluebird")
extend = require("extend")

module.exports = (->
  service = {}

  service.getStagePos = (data, cb)->
    if data.pos
      retrun cb(null, data.pos)
    else
      Stage.find {
        idProject: data.idProject
      }, (err, results)->
        if err
          return cb(err, null)
        else
          return cb(null, (results.length+1)*1000)

  service
)()