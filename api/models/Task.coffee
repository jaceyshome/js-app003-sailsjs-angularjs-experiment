Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idTaskType:
      model: "taskType"
    idStage:
      model: "stage"
      required: true
    idProject:
      model: "project"
      required: true
    idState:
      model: "state"
    name:
      type: "string"
    description:
      type: "string"
    startDate:
      type: "date"
    endDate:
      type: "date"
    items:
      type: "array"
    pos:
      type: "float"
      defaultsTo: 0

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model

)()


