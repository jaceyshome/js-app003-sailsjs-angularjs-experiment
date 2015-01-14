Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idTaskType:
      type: "string"
    idStage:
      type: "string"
      required: true
    idProject:
      type: "string"
      required: true
    idState:
      type: "string"
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
    order:
      type: "integer"
      defaultsTo: null

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model

)()


