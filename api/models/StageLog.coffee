Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    text:
      type: "string"

  model.beforeCreate = (data, next) ->
    next()

  model.beforeDestroy = (data, next) ->
    next()

  model)()


