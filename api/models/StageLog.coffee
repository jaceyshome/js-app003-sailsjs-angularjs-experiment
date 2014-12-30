Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    text:
      type: "string"


  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


