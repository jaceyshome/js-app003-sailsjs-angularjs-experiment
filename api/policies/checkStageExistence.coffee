module.exports = (req, res, next)->
  console.log "check stage existence!!!!!!!!!!!"
  return res.send(400, { message: 'Bad Request.'}) unless req.param("id")
  return res.send(400, { message: 'Bad Request.'}) unless req.param("idProject")
  Stage.findOne {
    id:req.param("id")
    idProject:req.param("idProject")
  }, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request'}) unless result
    return next() if result.id is req.param("id") and result.idProject is req.param("idProject")
    return res.send(400, { message: 'Bad Request'})