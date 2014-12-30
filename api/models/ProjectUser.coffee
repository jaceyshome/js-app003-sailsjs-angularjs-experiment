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


  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


