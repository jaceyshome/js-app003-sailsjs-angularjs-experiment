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
      result = null
      for key of data.attributes
        if data.attributes.hasOwnProperty(key)
          result = checkRequired(data,key)
          if (result) then return result
          if (result = checkEmail(data,key)) then return result
          if (result = checkMaxLength(data,key)) then return result
          if (result = checkMinLength(data,key)) then return result
      return result

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
        return {message:msg,key:key}
      else
        return null

    checkEmail = (data, key)->
      return null unless data.attributes[key].email
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      msg = "Invalid email"
      if re.test(data.values[key]) then return null else return {message:msg,key:key}

    checkMinLength = (data, key)->
      return null unless data.attributes[key].minLength
      msg = data.key+" miniumn length is "+data.attributes[key].minLength
      if data.values[key].length < data.attributes[key].minLength
        return {message:msg,key:key}
      else
        return null

    checkRequired = (data, key)->
      return null unless data.attributes[key].required
      msg = key+" is required"
      unless data.values[key]
        return {message:msg,key:key}
      else
        return null

    service
