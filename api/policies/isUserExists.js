module.exports = function(req, res, next) {
  var id, query, shortLink;
  if (!req.param("id")) {
    return res.send(400, {
      message: 'Bad Request.'
    });
  }
  if (!req.param("shortLink")) {
    return res.send(400, {
      message: 'Bad Request.'
    });
  }
  id = req.param("id");
  shortLink = req.param("shortLink");
  query = "SELECT id, shortLink, name, password FROM users WHERE id = " + id + " AND shortLink = '" + shortLink + "'";
  return User.query(query, function(err, result) {
    if (err) {
      return res.send({
        message: err
      });
    }
    if ((result != null ? result.length : void 0) !== 1) {
      return res.send(400, {
        message: 'Bad Request.'
      });
    }
    if (result[0].id === req.param("id") && result[0].shortLink === req.param("shortLink")) {
      return next();
    }
    return res.send(400, {
      message: 'Bad Request.'
    });
  });
};
