YAML = require('yamljs')
CommonHelper = require('../helpers/Common')

module.exports = (()->
  userModel = {}
  userModel.tableName =  "Users" #point to tableName
  userModel.migrate = "safe"
  userModel.attributes = YAML.load('validations/user.yml')
  delete userModel.attributes.confirmPassword
  userModel.attributes.password.maxLength = 256

  userModel.beforeCreate = (values, next) ->
    return next(err: [ "Password is required." ]) unless values.password
    CommonHelper.generateShortLink(userModel.attributes.shortLink.maxLength).then (result)->
      values.shortLink = result
      CommonHelper.generateUserPassword(values.password).then((encryptedPassword)->
        values.password = encryptedPassword
        next()
      ).catch(()->
        next(err)
      )

  userModel
)()


