Crypto = require('crypto')
Bcrypt = require("bcryptjs")
Promise = require("bluebird")
module.exports = (()->
  helper = {}

  helper.generateShortLink = (length)->
    new Promise (resolve, reject)->
      length = length || 24
      result = helper.randomValueBase64(length)
      resolve(result)

  helper.randomValueBase64 = (length)->
    Crypto.randomBytes(Math.ceil(length * 3 / 4))
      .toString('base64')   # convert to base64 format
      .slice(0, length)     # return required number of characters
      .replace(/\+/g, '0')  # replace '+' with '0'
      .replace(/\//g, '0')

  helper.generateUserPassword = (password)->
    new Promise (resolve, reject)->
      Bcrypt.hash password, 8, (err, encryptedPassword) ->
        return reject() if err
        return resolve(encryptedPassword)

  helper
)()