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
    values.shortLink = CommonHelper.generateShortLink userModel.attributes.shortLink.maxLength
    require("bcryptjs").hash values.password, 8, passwordEncrypted = (err, encryptedPassword) ->
      return next(err) if err
      values.password = encryptedPassword
      next()

  userModel
)()


