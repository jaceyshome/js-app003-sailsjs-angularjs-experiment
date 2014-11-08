CommonHelper = require('../helpers/Common')
module.exports = (->
  ctrl = {}
  ctrl.create = (req, res, next) ->
    User.create req.params.all(), userCreated = (err, user) ->
      return next(err) if err
      user.save (err, user) ->
        return next(err) if err
        User.publishCreate
          id: user.id
          shortLink: user.shortLink
          name: user.name
          email: user.email
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
        email:user[0].email
        shortLink:user[0].shortLink
      res.json userJson
    )

  ctrl.all = (req, res, next) ->
    User.query "SELECT name, email, shortLink FROM users", (err,users)->
      return next(err) if err or not users
      res.json users

  ctrl.update = (req, res, next) ->
    userObj =
      name: req.param("name")
      email: req.param("email")
      password: req.param("password")
    CommonHelper.generateUserPassword(userObj.password).then (encryptedPassword)->
      userObj.password = encryptedPassword
      query = " UPDATE users
              SET password = '#{userObj.password}'
              WHERE id = #{req.param('id')}
              AND shortLink = '#{req.param('shortLink')}'"
      User.query query, (err, result) ->
        return next(err) if err
        User.publishUpdate(req.param("id"),{
          id: req.param("id")
          shortLink: req.param("shortLink")
          name: req.param("name")
          email: req.param("email")
        }, req.socket)
        res.json "1"

  ctrl.destroy = (req, res, next) ->
    User.findOne req.param("shortLink"), userDestroyed = (err, user) ->
      return next(err) if err
      return next("User doesn't exist.")  unless user
      User.destroy req.param("shortLink"), userDestroyed = (err) ->
        return next(err)  if err
        User.publishDestroy req.param("shortLink"), req.socket
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
  ctrl
)()