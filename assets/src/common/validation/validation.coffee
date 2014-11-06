define [
  'angular'
  'common/validation/user'
], (angular)->
  module = angular.module 'common.validation', []
  module.factory 'Validation', (UserAttributes)->
    _attributeModels = {
      user: UserAttributes
    }

    service = {}

    service.getModelAttributes = (modelName, keys)->
      return null unless modelName or _attributeModels[modelName]
      return generateAttributes(modelName, keys) if keys and _attributeModels[modelName]
      return angular.copy data[modelName]

    service.validateAttributes = (data)->
      result = null
      for key of data.attributes
        if data.attributes.hasOwnProperty(key)
          if (result = checkRequired(data,key)) then return result
          if (result = checkType(data,key)) then return result
          if (result = checkEmail(data,key)) then return result
          if (result = checkMaxLength(data,key)) then return result
          if (result = checkMinLength(data,key)) then return result
          if (result = checkMatchingField(data,key)) then return result
      return result

    service.validateDate = (day, month, year)->
      tempDay = parseInt(day)
      return false if(isNaN(tempDay) || tempDay < 1 || tempDay > 31)
      if(month == 4 || month == 6 || month == 9 || month == 11)
        if(tempDay < 1 || tempDay > 30)
          return false
      if(month == 2)
        remainder = year%4
        if(remainder == 0)
          if(tempDay < 1 || tempDay > 29)
            return false
        else
          if(tempDay < 1 || tempDay > 28)
            return false
      tempDob = new Date()
      tempDob.setFullYear(day, month, year)
      today = new Date()
      return false if(tempDob > today)
      return true

    service.validateMonth = (month)->
      return false if(month.length < 1 || month.length > 2 )
      tempMonth = parseInt(month)
      return false if(isNaN(tempMonth) || tempMonth < 1 || tempMonth > 12)
      return true

    service.validateYear = (year)->
      return false if year.length isnt 4
      return false if isNaN(year)
      return true

    service.validateDateString = (date)->
      return false unless checkDateString(date)
      data = date.split('-')
      if(data.length != 3)
        data = date.split('/')
        if(data.length != 3)
          return false
      service.validateYear(data[2]) and
      service.validateMonth(data[1]) and
      service.validateDate(data[0], data[1], data[2])

    #----------------------------- private functions ------------------------------------

    checkDateString = (date) ->
      pattern = new RegExp("[^-/0123456789]")
      unless date.match(pattern) then return true else return false

    generateAttributes = (modelName, keys)->
      model = _attributeModels[modelName]
      attributes = {}
      for key in keys
        attributes[key] = model[key]
      attributes

    checkMaxLength = (data, key)->
      return null unless data.attributes[key].maxLength
      if data.values[key].length > data.attributes[key].maxLength
        return {key:key, msg:generateKeyWords(key)+" max length is "+data.attributes[key].maxLength}
      else
        return null

    checkMinLength = (data, key)->
      return null unless data.attributes[key].minLength
      if data.values[key].length < data.attributes[key].minLength
        return {key:key, msg:generateKeyWords(key)+" miniumn length is "+data.attributes[key].minLength}
      else
        return null

    checkEmail = (data, key)->
      return null unless data.attributes[key].email
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      return null if re.test(data.values[key])
      return {key:key, msg:"Invalid email"}

    checkRequired = (data, key)->
      return null unless data.attributes[key]?.required
      return {key:key,msg:generateKeyWords(key)+" is required"} unless data.values[key]
      return null

    checkType = (data,key)->
      return null unless data.attributes[key].type
      if (result = checkNumber(data,key)) then return result
      if (result = checkBoolean(data,key)) then return result
      if (result = checkDate(data,key)) then return result
      return null

    checkNumber = (data, key)->
      return null unless data.attributes[key].type is 'number'
      return null if !isNaN(data.values[key])
      return {key:key,msg:generateKeyWords(key)+' should be number'}

    checkBoolean = (data, key)->
      return null unless data.attributes[key].type is 'boolean'
      return null if typeof ConvertStringToBoolean(data.values[key]) is 'boolean'
      return {key:key,msg:generateKeyWords(key)+' should be boolean true or false'}

    ConvertStringToBoolean = (string) ->
      switch string.toLowerCase()
        when "true", "yes", "1"
          true
        when "false", "no", "0", null
          false
        else
          Boolean string

    checkDate = (data, key)->
      return null unless data.attributes[key].type is 'date'
      return {key:key, msg:generateKeyWords(key)+" is not a valid date"} unless service.validateDateString(data.values[key])
      return null

    checkMatchingField = (data, key)->
      return null unless data.attributes[key].match
      matchKey = data.attributes[key].match
      if data.values[matchKey] isnt data.values[key]
        return {key:key, msg:generateKeyWords(key) + ' does not match ' + generateKeyWords(matchKey)}
      else
        return null

    #------------------------------------- help functions ------------------------
    generateKeyWords = (key)->
      words = key.match(/[A-Z]?[a-z]+|[0-9]+/g)
      return words.join(" ").toLowerCase()

    service