Promise = require("bluebird")
extend = require("extend")
module.exports = (->
  service = {}

  #------------------ api functions ---------------
  service.specifyProject = (project,cb)->
    Promise.props({
      project: getProjectAsync(project)
      stages: getProjectStagesAsync(project)
    }).then((result)->
      data = result.project
      data.stages = result.stages
      handleResult null, data, cb
    ).catch((err)->
      handleResult err, null, cb
    )

  #------------------ private functions -----------
  getProjectAsync = (project)->
    Project.findOne({
      id: project.id
      shortLink: project.shortLink
    })

  getProjectStagesAsync = (project)->
    Stage.find({idProject:project.id}).sort({pos:1})

  handleResult = (err, result,cb)->
    return cb(err,result) if typeof cb is 'function'
    return false

  service
)()