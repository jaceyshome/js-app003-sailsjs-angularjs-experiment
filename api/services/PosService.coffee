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
        return cb(err, null) if err
        if results.length is 0
          data.pos = sails.config.constants.POS_INITIATION_VALUE
        else
          data.pos = (results[results.length-1].pos - sails.config.constants.POS_STEP)
        return cb(null, data.pos)

  service
)()