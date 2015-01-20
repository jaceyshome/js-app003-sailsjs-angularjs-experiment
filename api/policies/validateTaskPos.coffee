module.exports = (req, res, next)->
   if 'pos' in req.params.all()
      if req.params('pos') is null
        delete req.params('pos')
        PosService.getTaskPos req.params.all(), (err, pos)->
          req.params('pos') = pos
          next()
   else
     next()
