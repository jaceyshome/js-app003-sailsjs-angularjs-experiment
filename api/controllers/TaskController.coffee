Promise = require("bluebird")
module.exports = (->
  ctrl = {}

  ctrl.create = (req, res, next) ->
    Task.create req.params.all(), (err, task) ->
      return next(err) if err
      Task.publishCreate task, req.socket
      res.json task

  ctrl.specifics = (req, res, next) ->
    Task.findOne({
      id: req.param('id')
      idStage: req.param('idStage')
      idProject: req.param('idProject')
    }).exec((err, task)->
      return next(err) if err or not task
      jsonData = task
      res.json jsonData
    )

  ctrl.all = (req, res, next) ->
    Task.find {
      idStage: req.param('idStage')
      idProject: req.param('idProject')
    },(err, results)->
      return next(err) if err or not results
      res.json results

  ctrl.update = (req, res, next) ->
    Task.update {
      id: req.param("id")
      idProject: req.param("idProject")
      idStage: req.param("idStage")
    }, req.params.all(), (err, result)->
      return next(err) if err
      Task.publishUpdate(req.param("id"), result, req.socket) #TODO task publish update
      res.send 200

  ctrl.destroy = (req, res, next) ->
    Task.destroy {
      id: req.param("id")
      idProject: req.param("idProject")
      idStage: req.param("idStage")
    }, (err) ->
      return next(err) if err
      Task.publishDestroy req.param("id"), req.socket
      res.send 200

  ctrl.subscribe = (req, res, next) ->
    Task.find (err, results) ->
      return next(err) if err
      Task.watch req.socket
      Task.subscribe req.socket, results
      res.send 200

  ctrl

)()