Crypto = require('crypto')
module.exports = (()->
  helper = {}

  helper.generateShortLink = (length)->
    length = length || 12
    result = helper.randomValueBase64(length)
    return result

  helper.randomValueBase64 = (length)->
    Crypto.randomBytes(Math.ceil(length * 3 / 4))
      .toString('base64')   # convert to base64 format
      .slice(0, length)     # return required number of characters
      .replace(/\+/g, '0')  # replace '+' with '0'
      .replace(/\//g, '0')

  helper
)()