Promise = require("bluebird")

module.exports = (->
  service = {}

  #--------------------------------------- api functions -----------------------------------------
  service.destroyProject = (project,cb)->
    destroyProjectStages project, (err, result)->
      if err then return handleResult(err,null,cb)
      destroyProject project, (err, result)->
        if err then return handleResult(err,null,cb)
        return handleResult(null,result,cb)

  #--------------------------------------- private functions -------------------------------------
  destroyProjectStages = (project, cb)->
    Stage.destroy {
      idProject:project.id
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  destroyProject = (project, cb)->
    return handleResult('Bad Request', true, cb) unless project.id
    return handleResult('Bad Request', true, cb) unless project.shortLink
    Project.destroy {
      id:project.id
      shortLink: project.shortLink
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  handleResult = (err, result,cb)->
    return cb(err,result) if typeof cb is 'function'
    return false

  service
)()