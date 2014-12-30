Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    name:
      type: "string"
      maxLength: 200
    description:
      type: "string"
      maxLength: 3000
    startDate:
      type: "date"
    endDate:
      type: "date"
    stateId:
      type: "string"
    budgetedHours:
      type: "float"
      defaultsTo: 0

  model.beforeCreate = (values, next) ->
    next()

  model.beforeDestroy = (values, next) ->
    next()

  model)()


