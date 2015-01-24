Promise = require("bluebird")
module.exports = (->
  ctrl = {}

  ctrl.create = (req, res, next) ->
    PosService.setStagePos req.params.all(), (err, pos)->
      return next(err) if err
      data = req.params.all()
      data.pos = pos
      Stage.create data, (err, stage) ->
        return next(err) if err
        Stage.publishCreate stage, req.socket
        res.json stage

  ctrl.specify = (req, res, next) ->
    return res.send(400, { message: 'Bad Request.'}) unless req.param("idProject")
    return res.send(400, { message: 'Bad Request.'}) unless req.param("id")
    Stage.findOne({
      id: req.param('id')
      idProject: req.param('idProject')
    }).exec((err, stage)->
      return next(err) if err or not stage
      res.json stage
    )

  ctrl.all = (req, res, next) ->
    Stage.find {
      idProject:req.param('idProject')
    }, (err, results)->
      return next(err) if err or not results
      res.json results

  ctrl.update = (req, res, next) ->
    data = req.params.all()
    delete data.tasks
    delete data._csrf
    Stage.update {
      id: req.param("id")
    }, req.params.all(), (err, results)->
      return next(err) if err
      Stage.publishUpdate(req.param("id"), results[0], req.socket) #TODO stage publish update
      res.send 200

  ctrl.destroy = (req, res, next) ->
    DestroyService.destroyStage {
      id: req.param("id")
    }, (err, result) ->
      return next(err) if err
      Stage.publishDestroy req.param("id"), req.socket
      res.send 200

  ctrl.subscribe = (req, res, next) ->
    Stage.find (err, results) ->
      return next(err) if err
      Stage.watch req.socket
      Stage.subscribe req.socket, results
      res.send 200

  ctrl)()