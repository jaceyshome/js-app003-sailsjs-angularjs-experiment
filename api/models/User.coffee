module.exports =
  tableName: "Users" #point to tableName
  migrate: "safe"
  attributes:
    name:
      type: "string"
      required: true
      maxLength: 100
    email:
      type: "string"
      email: true
      required: true
      maxLength: 100
    password:
      type: "string"
      required: true
      maxLength: 100
    online:
      type: "boolean"
      defaultsTo: false

  beforeCreate: (values, next) ->
    return next(err: [ "Password is required." ])  unless values.password
    require("bcryptjs").hash values.password, 8, passwordEncrypted = (err, encryptedPassword) ->
      return next(err)  if err
      values.password = encryptedPassword
      next()
