Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    name:
      type: "string"
    autherization:
      type: "boolean"
      defaultsTo: false
    projectId:
      type: "string"
      required: true
    userId:
      type: "string"
      required: true

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


