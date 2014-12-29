YAML = require('yamljs')
CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  userModel = {}
  userModel.attributes =
    name:
      type: "string"
      required: true
      maxLength: 45
      unique: true
    email:
      type: "string"
      email: true
      required: true
      maxLength: 45
    password:
      type: "string"
      required: true
      maxLength: 256
    avator:
      type: "string"
      maxLength: 1000
    online:
      type: "boolean"
      defaultsTo: false
    isAdmin:
      type: "boolean"
      defaultsTo: false
    shortLink:
      type: "string"
      maxLength: 24
      unique: true

  userModel.beforeCreate = (values, next) ->
    return next(err: [ "Password is required." ]) unless values.password
    CommonHelper.generateShortLink(userModel.attributes.shortLink.maxLength)
    .then (result)->
      values.shortLink = result
      CommonHelper.generateUserPassword(values.password)
      .then((encryptedPassword)->
        values.password = encryptedPassword
        next()
      ).catch(()->
        next(err: [ "Internal Server Error." ])
      )

  userModel.beforeDestroy = (values, next) ->
    #TODO check admin and current user
    #TODO check user
    next()

  userModel
)()


