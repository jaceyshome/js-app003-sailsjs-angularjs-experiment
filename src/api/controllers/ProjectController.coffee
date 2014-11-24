CommonHelper = require('../helpers/Common')
Promise = require("bluebird")
module.exports = (->
  ctrl = {}
  ctrl.create = (req, res, next) ->
    Project.create req.params.all(), (err, project) ->
      return next(err) if err
      project.save (err, project) ->
        return next(err) if err
        Project.publishCreate
          id: project.id
          name: project.name
        , req.socket
        projectJson =
          id: project.id
          name:project.name
          description:project.description
          shortLink: project.shortLink
        res.json projectJson

  ctrl.specifics = (req, res, next) ->
    Project.findByShortLink(req.param('shortLink')).exec((err, project)->
      return next(err) if err or not project
      projectJson =
        id: project[0].id
        name:project[0].name
        description:project[0].description
        shortLink:project[0].shortLink
      res.json projectJson
    )

  ctrl.all = (req, res, next) ->
    #TODO check admin user
    Project.query "SELECT id, name, description, shortLink FROM projects", (err,projects)->
      return next(err) if err or not projects
      res.json projects

  ctrl.update = (req, res, next) ->
    return next(err: ["forbidden"]) unless req.param("id")
    return next(err: ["forbidden"]) unless req.param("shortLink")
    CommonHelper.checkProjectExists({
      id:req.param("id"),
      shortLink:req.param("shortLink")
    }).then (result)->
      return next(err: ["unauthourized"]) unless result
      projectObj =
        name: req.param("name")
        description: req.param("description")
      Project.update req.param("id"), projectObj, (err) ->
        return next(err)  if err
        Project.publishUpdate(req.param("id"),{
          id: req.param("id")
          name: req.param("name")
        }, req.socket)
        res.send 200

  ctrl.destroy = (req, res, next) ->
    return next(err: ["unauthourized"]) unless req.param("id")
    return next(err: ["unauthourized"]) unless req.param("shortLink")
    CommonHelper.checkProjectExists({
      id:req.param("id"),
      shortLink:req.param("shortLink")
    }).then (result)->
      return next(err: ["unauthourized"]) unless result
      Project.destroy req.param("id"), (err) ->
        return next(err) if err
        Project.publishDestroy req.param("id"), req.socket
        res.send 200

  ctrl.subscribe = (req, res, next) ->
    Project.find (err, projects) ->
      return next(err) if err
      Project.watch req.socket
      Project.subscribe req.socket, projects
      res.send 200

  ctrl._config = {}


  ctrl
)()