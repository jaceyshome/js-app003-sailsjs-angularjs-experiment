CommonHelper = require('../helpers/Common')
Promise = require("bluebird")
module.exports = (->
  ctrl = {}
  ctrl.create = (req, res, next) ->
    User.create req.params.all(), userCreated = (err, user) ->
      return next(err) if err
      user.save (err, user) ->
        return next(err) if err
        User.publishCreate
          id: user.id
          name: user.name
          online: user.online
        , req.socket
        userJson =
          id: user.id
          name:user.name
          email:user.email
          shortLink:user.shortLink
          online: user.online
        res.json userJson

  ctrl.specifics = (req, res, next) ->
    User.findByShortLink(req.param('shortLink')).exec((err, user)->
      return next(err) if err or not user
      userJson =
        id: user[0].id
        name:user[0].name
        shortLink:user[0].shortLink
      res.json userJson
    )

  ctrl.all = (req, res, next) ->
    User.query "SELECT id, name, email, shortLink FROM users", (err,users)->
      return next(err) if err or not users
      res.json users

  ctrl.update = (req, res, next) ->
    userObj =
      email: req.param("email")
      password: req.param("password")
    User.update req.param("id"), userObj, (err) ->
      return next(err)  if err
      User.publishUpdate(req.param("id"),{
        id: req.param("id")
        name: req.param("name")
        email: req.param("email")
        }, req.socket)
      res.json "1"

  ctrl.destroy = (req, res, next) ->
    User.destroy req.param("id"), (err) ->
      return next(err) if err
      User.publishDestroy req.param("id"), req.socket
    res.json "1"

  ctrl.subscribe = (req, res, next) ->
    # Find all current users in the user model
    User.find (err, users) ->
      return next(err) if err
      # subscribe this socket to the User model classroom
      #User.publishCreate
      User.subscribe req.socket
      # subscribe this socket to the user instance rooms
      #User.publishDestroy
      #User.publishUpdate
      User.subscribe req.socket, users
      # This will avoid a warning from the socket for trying to render
      # html over the socket.
      res.send 200

  ctrl._config = {}

  checkUserExist = (user)->
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

  ctrl
)()