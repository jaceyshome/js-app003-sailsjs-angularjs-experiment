Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idState:
      type: "string"
    idCurrentStage:
      type: "string"
    name:
      type: "string"
      required: true
      maxLength: 200
    description:
      type: "string"
    priority:
      type: "boolean"
      defaultsTo: false
    shortLink:
      type: "string"
      unique: true
      maxLength: 24
    startDate:
      type: "date"
    endDate:
      type: "date"
    isClosed:
      type: "boolean"
      defaultsTo: false
    stages:
      collection: 'stage'
      via: 'idProject'


  model.beforeCreate = (data, next) ->
    Utils.generateShortLink(model.attributes.shortLink.maxLength)
    .then (result)->
      data.shortLink = result
      next()
    .catch(()->
      next(err: [ "Internal Server Error." ])
    )

  model
)()


