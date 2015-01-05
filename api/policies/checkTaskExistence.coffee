module.exports = (req, res, next)->
  reqId = req.param("id") || req.param("idTask")
  return res.send(400, { message: 'Bad Request.'}) unless reqId
  return res.send(400, { message: 'Bad Request.'}) unless req.param("idProject")
  return res.send(400, { message: 'Bad Request.'}) unless req.param("idStage")
  Task.findOne {
    id:reqId
    idProject:req.param("idProject")
    idStage:req.param("idStage")
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request'}) unless result
    if result.id.toString() is reqId.toString() and result.idProject.toString() is req.param("idProject").toString() and result.idStage.toString() is req.param("idStage").toString()
      return next()
    return res.send(400, { message: 'Bad Request'})