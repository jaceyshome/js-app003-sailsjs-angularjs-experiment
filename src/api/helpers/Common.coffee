Crypto = require('crypto')
Bcrypt = require("bcrypt-nodejs")
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
      Bcrypt.hash password, null, null, (err, hash) ->
        return reject() if err
        return resolve(hash)

  helper.checkUserPassword = (user)->
    new Promise (resolve, reject)->
      query = "
          SELECT id, shortLink, name, password
          FROM users
          WHERE id = #{user.id}
          AND shortLink = '#{user.shortLink}'"
      User.query query, (err, result) ->
        return resolve(false) unless result.length is 1
        return resolve(result[0]) if result[0].id is user.id and result[0].shortLink is user.shortLink
        return resolve(false)
        Bcrypt.compare user.password,result[0].password,(err, res)->
          if err then resolve(false)
          resolve(res)

  helper.checkUserExists = (user)->
    new Promise (resolve, reject)->
      return reject(null) unless user.id
      return reject(null) unless user.shortLink
      query = "
        SELECT id, shortLink, name, password
        FROM users
        WHERE id = #{user.id}
        AND shortLink = '#{user.shortLink}'"
      User.query query, (err, result) ->
        return resolve(false) unless result?.length is 1
        return resolve(result[0]) if result[0].id is user.id and result[0].shortLink is user.shortLink
        return resolve(false)

  helper.checkProjectExists = (project)->
    new Promise (resolve, reject)->
      return reject(null) unless project.id
      return reject(null) unless project.shortLink
      query = "
          SELECT id, shortLink, name
          FROM projects
          WHERE id = #{project.id}
          AND shortLink = '#{project.shortLink}'"
      Project.query query, (err, result) ->
        return resolve(false) unless result.length is 1
        return resolve(result[0]) if result[0].id is project.id and result[0].shortLink is project.shortLink
        return resolve(false)

  helper
)()