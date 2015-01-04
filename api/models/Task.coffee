Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idTaskType:
      type: "string"
    idStage:
      type: "string"
    idProject:
      type: "string"
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

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model

)()


