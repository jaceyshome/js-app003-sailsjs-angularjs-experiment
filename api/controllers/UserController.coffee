CommonHelper = require('../helpers/Common')
module.exports = (->
  ctrl = {}
  ctrl.create = (req, res, next) ->
    User.create req.params.all(), userCreated = (err, user) ->
      return next(err) if err
      req.session.cookie.expires = new Date((new Date()).getTime() + 60000)
      req.session.authenticated = true
      req.session.user = user
      user.online = true
      user.save (err, user) ->
        return next(err) if err
        User.publishCreate
          id: user.id
          name: user.name
          email: user.email
          online: true
        , req.socket
        res.json user

  ctrl.specifics = (req, res, next) ->
    User.findOne req.param("id"), foundUser = (err, user) ->
      return next(err) if err or not user
      res.json user

  ctrl.all = (req, res, next) ->
    User.find foundUsers = (err, users) ->
      return next(err) if err or not users
      res.json users

  ctrl.update = (req, res, next) ->
    userObj =
      name: req.param("name")
      email: req.param("email")
    User.update req.param("id"), userObj, userUpdated = (err) ->
      return next(err)  if err
      User.publishUpdate req.param("id"),
        loggedIn: true
        id: req.param("id")
      res.json "1"

  ctrl.destroy = (req, res, next) ->
    User.findOne req.param("id"), userDestroyed = (err, user) ->
      return next(err) if err
      return next("User doesn't exist.")  unless user
      User.destroy req.param("id"), userDestroyed = (err) ->
        return next(err)  if err
        User.publishDestroy req.param("id"), req.socket
      res.json "1"

  ctrl.subscribe = (req, res) ->
    # Find all current users in the user model
    User.find foundUsers = (err, users) ->
      return next(err)  if err
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