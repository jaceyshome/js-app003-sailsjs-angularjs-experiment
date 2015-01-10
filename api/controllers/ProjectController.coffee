Promise = require("bluebird")
module.exports = (->
  ctrl = {}

  #------------------------- views ----------------------
  ctrl.new = (req, res, next)->
    res.view('app')

  ctrl.list = (req, res, next)->
    res.view('app')

  ctrl.details = (req, res, next)->
    res.view('app')

  ctrl.edit= (req, res, next)->
    res.view('app')

  #------------------------- crud ------------------------
  ctrl.create = (req, res, next) ->
    Project.create req.params.all(), (err, project) ->
      return next(err) if err
      Project.publishCreate project, req.socket
      res.json project

  ctrl.specifics = (req, res, next) ->
    return res.send(400, { message: 'Bad Request.'}) unless req.param("shortLink")
    return res.send(400, { message: 'Bad Request.'}) unless req.param("id")
    Project.findOne {
      id: req.param('id')
      shortLink:req.param('shortLink')
    } , (err, result)->
      return next(err) if err
      res.json result

  ctrl.all = (req, res, next) ->
    Project.find (err,projects)->
      return next(err) if err or not projects
      res.json projects

  ctrl.update = (req, res, next) ->
    data =
      name: req.param("name")
      description: req.param("description")
    Project.update req.param("id"), data, (err) ->
      return next(err)  if err
      Project.publishUpdate(req.param("id"),{
        id: req.param("id")
        name: req.param("name")
      }, req.socket)
      res.send 200

  ctrl.destroy = (req, res, next) ->
    DestroyService.destroyProject req.params.all(), (err)->
      return next(err) if err
      Project.publishDestroy req.param("id"), req.socket
      return res.send 200

  ctrl.subscribe = (req, res, next) ->
    Project.find (err, projects) ->
      return next(err) if err
      Project.watch req.socket
      Project.subscribe req.socket, projects
      res.send 200

  ctrl
)()