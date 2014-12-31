Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    name:
      type: "string"

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


