define [
  'angular'
  'common/validation/user'
], (angular)->
  module = angular.module 'common.validation', [
    'common.validation.userattributes'
  ]
  module.factory 'Validation', (UserAttributes)->
    _attributeModels = {
      user: UserAttributes
    }

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
      unless data.values[key]
        return {message:key+" is required",key:key}
      else
        return null

    checkType = (data,key)->
      return null unless key is 'type'
      if (result = checkNumber(data,key)) then return result

    checkNumber = (data, key)->
      return null unless data.attributes[key] is 'number'
      if !isNaN(data.values[key])
        return null
      else
        return {message:key+'should be number',key:key}

    checkMatchingField = (data, key)->
      return null unless data.attributes[key].match
      matchKey = data.attributes[key].match
      if data.values[matchKey] isnt data.values[key]
        return {message:key+'doesn\'t match '+matchKey,key:key}

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
          if (result = checkEmail(data,key)) then return result
          if (result = checkMaxLength(data,key)) then return result
          if (result = checkMinLength(data,key)) then return result
          if (result = checkMatchingField(data,key)) then return result
          if (result = checkType(data,key)) then return result
      return result

    service.validateNumber = (data)->
      return !isNaN(data)

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

    service