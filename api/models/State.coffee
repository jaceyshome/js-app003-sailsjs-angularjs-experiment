CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    name:
      type: "string"
      maxLength: 45


  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


