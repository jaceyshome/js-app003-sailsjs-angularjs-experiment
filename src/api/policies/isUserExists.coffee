
module.exports = (req, res, next) ->
  return res.send(400, { message: 'Bad Request.'}) unless req.param("id")
  return res.send(400, { message: 'Bad Request.'}) unless req.param("shortLink")
  id = req.param("id")
  shortLink = req.param("shortLink")
  query = "
      SELECT id, shortLink, name, password
      FROM users
      WHERE id = #{id}
      AND shortLink = '#{shortLink}'"
  User.query query, (err, result) ->
    if (err) then return res.send({ message: err })
    return res.send(400, { message: 'Bad Request.'}) unless result?.length is 1
    return next() if result[0].id is req.param("id") and result[0].shortLink is req.param("shortLink")
    return res.send(400, { message: 'Bad Request.'})