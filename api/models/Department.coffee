CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    name:
      type: "string"

  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


