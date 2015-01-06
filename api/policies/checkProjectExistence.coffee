module.exports = (req, res, next)->
  reqId = req.param("id") || req.param("idProject")
  return res.send(400, { message: 'Bad Request.'}) unless reqId
  return res.send(400, { message: 'Bad Request.'}) unless req.param("shortLink")
  Project.findOne {
    id:reqId
    shortLink:req.param("shortLink")
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request'}) unless result
    if result.id.toString() is reqId.toString() and result.shortLink is req.param("shortLink")
      return next()
    return res.send(400, { message: 'Bad Request'})