Promise = require("bluebird")

module.exports = (->
  service = {}

  #--------------------------------------- api functions -----------------------------------------
  service.destroyProject = (project,cb)->
    destroyProjectTasks project, (err, result)->
      if err then return handleResult(err,null,cb)
      destroyProjectStages project, (err, result)->
        if err then return handleResult(err,null,cb)
        destroyProject project, (err, result)->
          if err then return handleResult(err,null,cb)
          return handleResult(null,result,cb)

  service.destroyStage = (stage,cb)->
    destroyStageTasks stage, (err, result)->
      if err then return handleResult(err,null,cb)
      destroyStage stage, (err, result)->
        if err then return handleResult(err,null,cb)
        return handleResult(null,result,cb)

  #--------------------------------------- private functions -------------------------------------
  destroyProjectStages = (project, cb)->
    return handleResult("Bad Request.",true,cb) unless project?.id
    Stage.destroy {
      idProject:project.id
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  destroyProject = (project, cb)->
    return handleResult('Bad Request', true, cb) unless project?.id
    return handleResult('Bad Request', true, cb) unless project?.shortLink
    Project.destroy {
      id:project.id
      shortLink: project.shortLink
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  destroyProjectTasks = (project,cb)->
    return handleResult("Bad Request.",true,cb) unless project?.id
    Task.destroy {
      idProject: project.id
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  destroyStageTasks = (stage,cb)->
    return handleResult("Bad Request.",true,cb) unless stage?.id
    Task.destroy {
      idStage: stage.id
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  destroyStage = (stage,cb)->
    return handleResult("Bad Request.",true,cb) unless stage?.id
    Stage.destroy {
      id: stage.id
    }, (err)->
      if err then return handleResult(err,true,cb)
      return handleResult(null,true,cb)

  handleResult = (err, result,cb)->
    return cb(err,result) if typeof cb is 'function'
    return false

  service
)()