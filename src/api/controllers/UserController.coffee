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
        email:user[0].email
        shortLink:user[0].shortLink
      res.json userJson
    )

  ctrl.all = (req, res, next) ->
    #TODO check admin user
    User.query "SELECT id, name, email, shortLink FROM users", (err,users)->
      return next(err) if err or not users
      res.json users

  ctrl.update = (req, res, next) ->
    return res.send(400, { message: 'Bad Request.a'}) unless req.param("id")
    return res.send(400, { message: 'Bad Request.b'}) unless req.param("shortLink")
    return res.send(400, { message: 'Bad Request.c'}) unless req.param("password")
    data =
      id: req.param("id")
      shortLink: req.param("shortLink")
      password: req.param("password")
    CommonHelper.checkUserPassword(data)
    .then (result)->
      console.log "result!!!!!!!!!", result
      return next(err: ["unauthourized"]) unless result is true
      userObj =
        email: req.param("email")
      User.update req.param("id"), userObj, (err) ->
        return next(err)  if err
        User.publishUpdate(req.param("id"),{
          id: req.param("id")
          name: req.param("name")
          email: req.param("email")
        }, req.socket)
        res.send 200

  ctrl.destroy = (req, res, next) ->
    return next(err: ["unauthourized"]) unless req.param("id")
    return next(err: ["unauthourized"]) unless req.param("shortLink")
    CommonHelper.checkUserExists({
      id:req.param("id"),
      shortLink:req.param("shortLink")
    }).then (result)->
      return next(err: ["unauthourized"]) unless result
      User.destroy req.param("id"), (err) ->
        return next(err) if err
        User.publishDestroy req.param("id"), req.socket
        res.send 200

  ctrl.subscribe = (req, res, next) ->
    User.find (err, users) ->
      return next(err) if err
      # subscribe this socket to the User model classroom
      #User.publishDestroy
      #User.publishUpdate
      User.watch req.socket
      User.subscribe req.socket, users
      # This will avoid a warning from the socket for trying to render
      # html over the socket.
      res.send 200

  ctrl._config = {}


  ctrl
)()