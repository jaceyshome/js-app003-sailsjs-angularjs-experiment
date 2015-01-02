Promise = require("bluebird")

module.exports = (->
  service = {}

  handleResult = (err, result,cb)->
    return cb(err,result) if typeof cb is 'function'
    return false

  service.get = (data)->

  service.delete = (stage,cb)->
    if stage then Stage.create(stage).then((result)->
      handleResult(null, result, cb)).catch((err)->
      handleResult(err,null,cb)
    )

  service.destroyProject = (req)->
    return null

  service
)()