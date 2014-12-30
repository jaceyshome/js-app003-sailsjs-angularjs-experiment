CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
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
    taskTypeId:
      type: "string"

  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


