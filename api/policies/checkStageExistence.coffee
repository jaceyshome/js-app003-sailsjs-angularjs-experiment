module.exports = (req, res, next)->
  reqId = req.param("id") || req.param("idStage")
  return res.send(400, { message: 'Bad Request.'}) unless reqId
  Stage.findOne {
    id:reqId
    idProject:req.param("idProject")
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request.'}) unless result
    return next() if result.id.toString() is reqId.toString() and result.idProject is req.param("idProject")
    return res.send(400, { message: 'Bad Request.'})