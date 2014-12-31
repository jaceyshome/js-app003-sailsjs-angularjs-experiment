Promise = require("bluebird")

module.exports = (->
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
    projectId:
      type: "string"
      required: true
    budgetedHours:
      type: "float"
      defaultsTo: 0

  model.beforeCreate = (data, next) ->
    Project.findOne {
      id: data.projectId
      shortLink:data.projectShortLink
    }, (err, result) ->
      if (err) then return res.send({ message: err })
      return next(err: [ "Internal Server Error." ]) unless result
      return next() if result.id.toString() is data.projectId.toString() and result.shortLink is data.projectShortLink
      return next(err: [ "Internal Server Error" ])

  model.beforeDestroy = (data, next) ->
    next()

  model

)()


