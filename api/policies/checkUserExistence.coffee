module.exports = (req, res, next) ->
  return res.send(400, { message: 'Bad Request.'}) unless req.param("id")
  return res.send(400, { message: 'Bad Request.'}) unless req.param("shortLink")
  User.findOne {
    id:req.param("id")
    shortLink:req.param("shortLink")
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request.'}) unless result
    return next() if result.id is req.param("id") and result.shortLink is req.param("shortLink")
    return res.send(400, { message: 'Bad Request.'})