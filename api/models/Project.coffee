YAML = require('yamljs')
CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  projectModel = {}
  projectModel.attributes =
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

  projectModel.beforeCreate = (values, next) ->
    CommonHelper.generateShortLink(projectModel.attributes.shortLink.maxLength)
    .then (result)->
      values.shortLink = result
      next()
    .catch(()->
      next(err: [ "Internal Server Error." ])
    )

  projectModel.beforeDestroy = (values, next) ->
    #TODO check admin and current user
    #TODO check user
    next()

  projectModel
)()


