module.exports = (req, res, next)->
  reqId = req.param("id") || req.param("idStage")
  return res.send(400, { message: 'Bad Request.'}) unless reqId
  Stage.findOne {
    id:reqId
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request.'}) unless result
    return next() if result.id.toString() is reqId.toString()
    return res.send(400, { message: 'Bad Request.'})