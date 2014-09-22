YAML = require('yamljs')
CommonHelper = require('../helpers/Common')
module.exports = (()->
  userAttributes = YAML.load('validations/user.yml').user
  userModel = {}
  userModel.tableName =  "Users" #point to tableName
  userModel.migrate = "safe"
  userModel.attributes =
    name: userAttributes.name
    email: userAttributes.email
    password: userAttributes.password
    online: userAttributes.online
    isSuperAdmin: userAttributes.isSuperAdmin

  userModel.beforeCreate = (values, next) ->
    return next(err: [ "Password is required." ])  unless values.password
    values.shortLink = CommonHelper.generateShortLink()
    require("bcryptjs").hash values.password, 8, passwordEncrypted = (err, encryptedPassword) ->
      return next(err)  if err
      values.password = encryptedPassword
      next()

  userModel
)()


