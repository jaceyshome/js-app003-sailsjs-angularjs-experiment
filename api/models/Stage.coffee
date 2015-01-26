Promise = require("bluebird")

module.exports = (->
  model = {}
  model.attributes =
    idProject:
      model: "project"
      required: true
    idState:
      model: "state"
    name:
      type: "string"
      maxLength: 200
      required: true
    description:
      type: "string"
      maxLength: 3000
    budgetedHours:
      type: "float"
      defaultsTo: 0
    pos:
      type: "float"
      defaultsTo: 0
    startDate:
      type: "date"
    endDate:
      type: "date"
    tasks:
      collection: 'task'
      via: 'idStage'

  model.beforeCreate = (data, next) ->
    Project.findOne {
      id: data.idProject
    }, (err, result) ->
      if (err) then return res.send({ message: err })
      return next(err: [ "Bad Request." ]) unless result
      return next() if result.id.toString() is data.idProject.toString()
      return next(err: [ "Bad Request." ])

  model.beforeUpdate = (data, next)->
    #TODO validation
    delete data.tasks
    delete data._csrf
    next()

  model.afterUpdate = (data, next)->
    next()

  model

)()


