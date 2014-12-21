YAML = require('yamljs')
CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  userModel = {}
  userModel.tableName =  "users" #point to tableName
  userModel.migrate = "safe"
  userModel.attributes = YAML.load('assets/data/validations/user.yml')
  delete userModel.attributes.confirmPassword
  userModel.attributes.password.maxLength = 256

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


