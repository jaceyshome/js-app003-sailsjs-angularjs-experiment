bcrypt = require("bcryptjs")
module.exports =
  create: (req, res, next) ->
    if not req.param("name") or not req.param("password")
      console.log "required name or password"
      return next(err)
    User.findOneByName req.param("name"), foundUser = (err, user) ->
      if err or not user
        console.log "User not found"
        return next(err)
      bcrypt.compare req.param("password"), user.password, (err, valid) ->
        if err or not valid
          console.log "Password is wrong."
          return next(err)
        req.session.cookie.expires = new Date((new Date()).getTime() + 600000)
        req.session.authenticated = true
        req.session.User = user
        user.online = true
        user.save (err, user) ->
          return next(err)  if err
          res.json user
        res.json id: user.id

  destroy: (req, res, next) ->
    unless req.session.User
      req.session.destroy()
      res.json "1"
      return
    User.update req.session.User.id,
      online: false
    , userUpdated = (err) ->
        return next(err)  if err
        req.session.destroy()
        res.json "1"
