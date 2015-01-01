Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idTask:
      type: "string"
      required: true
    idUser:
      type: "string"
      required: true
    text:
      type: "string"
      maxLength: 1000
    estimatedHours:
      type: "float"
    spentHours:
      type: "float"

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


