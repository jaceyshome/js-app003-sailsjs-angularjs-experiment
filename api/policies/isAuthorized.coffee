module.exports = (req, res, next) ->

  # User is allowed, proceed to the next policy, 
  # or if this is the last policy, the controller
  authorized = false
  return next()  if req.session.authenticated and authorized
  # User is not allowed
  # (default res.forbidden() behavior can be overridden in `config/403.js`)
  if req.session.authenticated
    res.forbidden "You are not permitted to perform this action."
  else
    # Explicitly handle the 401 Unauthorized case...
    response =
      status: 401
      message: "You must authenticate first"

    if req.wantsJSON
      res.send response, 401
    else
      res.send response.message, 401