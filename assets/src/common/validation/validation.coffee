define [
  'angular'
  'common/validation/validation-data'
], (angular, validationData) ->
  appModule = angular.module 'common.validation', []
  appModule.factory "ValidationService", ()->
    data = validationData

    service = {}
    service.getModelAttributes = (modelName, keys)->
      return null unless modelName or data[modelName]
      return generateAttributes(modelName, keys) if keys and data[modelName]
      return angular.copy data[modelName]

    service.validate = (data)->
      msg = null
      for key of data.attributes.reverse()
        if data.attributes.hasOwnProperty(key)
          msg = checkRequired(data,key)
          if (msg) then return msg
          if (msg = checkEmail(data,key)) then return msg
          if (msg = checkMaxLength(data,key)) then return msg
          if (msg = checkMinLength(data,key)) then return msg
      return msg

    generateAttributes = (modelName, keys)->
      model = data[modelName]
      attributes = {}
      for key in keys
        attributes[key] = model[key]
      attributes

    checkMaxLength = (data, key)->
      return null unless data.attributes[key].maxLength
      msg = key+" max length is "+data.attributes[key].maxLength
      if data.values[key].length > data.attributes[key].maxLength
        return msg
      else
        return null

    checkEmail = (data, key)->
      return null unless data.attributes[key].email
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      msg = "Invalid email"
      if re.test(data.values[key]) then return null else return msg

    checkMinLength = (data, key)->
      return null unless data.attributes[key].minLength
      msg = data.key+" miniumn length is "+data.attributes[key].minLength
      if data.values[key].length < data.attributes[key].minLength
        return msg
      else
        return null

    checkRequired = (data, key)->
      return null unless data.attributes[key].required
      msg = key+" is required"
      unless data.values[key]
        return msg
      else
        return null

    service
