YAML = require('yamljs')
CommonHelper = require('../helpers/Common')

module.exports = (()->
  userModel = {}
  userModel.tableName =  "users" #point to tableName
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

  userModel.beforeUpdate = (values, next) ->
    #TODO check admin and current user
    return next(err: [ "Password is required." ]) unless values.password
    CommonHelper.generateUserPassword(values.password).then((encryptedPassword)->
      values.password = encryptedPassword
      next()
    ).catch(()->
      next(err)
    )

  userModel.beforeDestroy = (values, next) ->
    #TODO check admin and current user
    #TODO check user
    next()


  checkUserExists = (user)->
    new Promise (resolve, reject)->
      return reject(null) unless user.id
      return reject(null) unless user.shortLink
      query = "SELECT id, shortLink
              FROM users
              WHERE id = #{user.id}
              AND shortLink = '#{user.shortLink}'"
      User.query query, (err, result) ->
        console.log "result", result
        if result[0].id is user.id and result[0].shortLink is user.shortLink
          return resolve(true)
        else
          return resolve(false)

  userModel
)()


