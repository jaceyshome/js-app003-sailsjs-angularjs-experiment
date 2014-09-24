YAML = require('yamljs')
CommonHelper = require('../helpers/Common')

module.exports = (()->
  userModel = {}
  userModel.tableName =  "Users" #point to tableName
  userModel.migrate = "safe"
  userModel.attributes = YAML.load('validations/user.yml').user
  userModel.attributes.toJSON = ()->
    obj = @toObject()
    delete obj.password
    delete obj.isSuperAdmin
    return obj

  userModel.beforeCreate = (values, next) ->
    return next(err: [ "Password is required." ])  unless values.password
    require("bcryptjs").hash values.password, 8, passwordEncrypted = (err, encryptedPassword) ->
      return next(err) if err
      values.password = encryptedPassword
      values.shortLink = CommonHelper.generateShortLink userModel.attributes.shortLink.maxLength
      next()

  userModel
)()


