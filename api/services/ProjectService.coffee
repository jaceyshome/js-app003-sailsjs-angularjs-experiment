Promise = require("bluebird")
extend = require("extend")
_ = require('lodash')

module.exports = (->
  service = {}

  #------------------ api functions ---------------
  service.specifyProject = (restriction,cb)->
    Project.findOne(restriction)
    .populate('stages').sort({pos:1})
    .populate('tasks').sort({pos:1})
    .then((project)->
      handleResult null, project, cb
    ).catch((err)->
      if err then  handleResult err, null, cb
    )

  handleResult = (err, result,cb)->
    return cb(err,result) if typeof cb is 'function'
    return false

  service
)()