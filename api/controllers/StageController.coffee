Promise = require("bluebird")
module.exports = (->
  ctrl = {}

  ctrl.create = (req, res, next) ->
    Stage.create req.params.all(), (err, stage) ->
      return next(err) if err
      Stage.publishCreate stage, req.socket
      res.json stage

  ctrl.specifics = (req, res, next) ->
    Stage.findOne(req.param('id')).exec((err, stage)->
      return next(err) if err or not stage
      res.json stage
    )

  ctrl.all = (req, res, next) ->
    console.log "!!!!!!!!!!", all
    Stage.find {
      idProject:req.param('idProject')
    }, (err, results)->
      return next(err) if err or not results
      res.json results

  ctrl.update = (req, res, next) ->
    Stage.update req.param("id"), req.params.all(), (err)->
      return next(err) if err
      Stage.publishUpdate(req.param("id"), {}, req.socket)
      res.send 200

  ctrl.destroy = (req, res, next) ->
    Stage.destroy req.param("id"), (err) ->
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