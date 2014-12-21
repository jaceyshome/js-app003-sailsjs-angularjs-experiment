YAML = require('yamljs')
CommonHelper = require('../helpers/Common')
Promise = require("bluebird")

module.exports = (()->
  projectModel = {}
  projectModel.tableName =  "projects"
  projectModel.attributes = YAML.load('assets/data/validations/project.yml')

  projectModel.beforeCreate = (values, next) ->
    CommonHelper.generateShortLink(projectModel.attributes.shortLink.maxLength)
    .then (result)->
      values.shortLink = result
      next()
    .catch(()->
      next(err: [ "Internal Server Error." ])
    )

  projectModel.beforeDestroy = (values, next) ->
    #TODO check admin and current user
    #TODO check user
    next()

  projectModel
)()


