CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    text:
      type: "string"
      maxLength: 1000
    estimatedHours:
      type: "float"
    spentHours:
      type: "float"
    taskId:
      type: "string"
      required: true
    userId:
      type: "string"
      required: true

  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


