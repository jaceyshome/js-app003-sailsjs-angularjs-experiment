Promise = require("bluebird")

module.exports = (()->
  model = {}
  model.attributes =
    idDepartment:
      type: "string"
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

  model.beforeCreate = (data, next) ->
    return next(err: [ "Password is required." ]) unless data.password
    Utils.generateShortLink(model.attributes.shortLink.maxLength)
    .then (result)->
      data.shortLink = result
      Utils.generateUserPassword(data.password)
      .then((encryptedPassword)->
          data.password = encryptedPassword
        next()
      ).catch(()->
        next(err: [ "Internal Server Error." ])
      )

  model.beforeDestroy = (data, next) ->
    #TODO check admin and current user
    #TODO check user
    next()

  model
)()


