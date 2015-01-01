Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idTaskType:
      type: "string"
    name:
      type: "string"
    description:
      type: "string"
    startDate:
      type: "date"
    endDate:
      type: "date"
    stageId:
      type: "string"
    stateId:
      type: "string"
    items:
      type: "array"

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


