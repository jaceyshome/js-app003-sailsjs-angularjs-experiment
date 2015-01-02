Promise = require("bluebird")

module.exports = (->
  model = {}
  model.attributes =
    idProject:
      type: "string"
      required: true
    idState:
      type: "string"
    name:
      type: "string"
      maxLength: 200
    description:
      type: "string"
      maxLength: 3000
    startDate:
      type: "date"
    endDate:
      type: "date"
    budgetedHours:
      type: "float"
      defaultsTo: 0


  model.beforeCreate = (data, next) ->
    Project.findOne {
      id: data.idProject
    }, (err, result) ->
      if (err) then return res.send({ message: err })
      return next(err: [ "Bad Request." ]) unless result
      return next() if result.id.toString() is data.idProject.toString()
      return next(err: [ "Bad Request." ])

  model.beforeUpdate = (data,next)->
    return res.send(400, { message: 'Bad Request.'}) unless data.id
    return res.send(400, { message: 'Bad Request.'}) unless data.idProject
    Stage.findOne {
      id:data.id
      idProject:data.idProject
    }, (err, result) ->
      if (err) then return res.send({ message: err })
      return res.send(400, { message: 'Bad Request'}) unless result
      return next() if result.id is data.id and result.idProject is data.idProject
      return res.send(400, { message: 'Bad Request'})

  model.beforeDestroy = (data, next) ->
    next()

  model

)()


