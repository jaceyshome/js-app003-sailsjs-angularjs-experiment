CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
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
    stateId:
      type: "string"
    currentStageId:
      type: "string"
    startDate:
      type: "date"
    endDate:
      type: "date"


  model.beforeCreate = (values, next) ->
    CommonHelper.generateShortLink(model.attributes.shortLink.maxLength)
    .then (result)->
      values.shortLink = result
      next()
    .catch(()->
      next(err: [ "Internal Server Error." ])
    )

  model.beforeDestroy = (values, next) ->
    #TODO check admin and current user
    #TODO check user
    next()

  model
)()


