Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idProject:
      type: "string"
      required: true
    idUser:
      type: "string"
      required: true
    name:
      type: "string"
    autherization:
      type: "boolean"
      defaultsTo: false

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


