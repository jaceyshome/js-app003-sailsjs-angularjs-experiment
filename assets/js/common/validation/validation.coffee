define [
  'angular'
  'model-attributes'
], (angular, modelAttributes)->
  module = angular.module 'common.validation', []
  module.factory 'Validation', ()->
    console.log "validation attributes", modelAttributes
    _modelsAttributes = modelAttributes
    service = {}

    service.getModelAttributes = (modelName, keys)->
      return null unless modelName or _modelsAttributes[modelName]
      return generateAttributes(modelName, keys) if keys and _modelsAttributes[modelName]
      return angular.copy data[modelName]

    service.validateAttributes = (data)->
      result = null
      for key of data.attributes
        if data.attributes.hasOwnProperty(key)
          if (result = checkRequired(data,key)) then return result
          if (result = checkType(data,key)) then return result
          if (result = checkEmail(data,key)) then return result
          if (result = checkPostalAddress(data,key)) then return result
          if (result = checkPostCode(data,key)) then return result
          if (result = checkIPAddress(data,key)) then return result
          if (result = checkCreditCard(data,key)) then return result
          if (result = checkMaxLength(data,key)) then return result
          if (result = checkMinLength(data,key)) then return result
          if (result = checkMatchingField(data,key)) then return result
      return result

    #----------------------------- private functions ------------------------------------
    validateDateString = (date)->
      return false unless checkDateString(date)
      data = date.split('-')
      if(data.length != 3)
        data = date.split('/')
        if(data.length != 3)
          return false
      validateYear(data[0]) and validateMonth(data[1]) and validateDate(data[0], data[1], data[2])

    checkDateString = (date) ->
      pattern = new RegExp("[^-/0123456789]")
      unless date.match(pattern) then return true else return false

    validateYear = (year)->
      return false if year.length isnt 4
      return false if isNaN(year)
      return true

    validateMonth = (month)->
      return false if(month.length < 1 || month.length > 2 )
      tempMonth = parseInt(month)
      return false if(isNaN(tempMonth) || tempMonth < 1 || tempMonth > 12)
      return true

    validateDay = (day)->
      return false if(day.length < 1 || day.length > 2 )
      tempDay = parseInt(day)
      return false if(isNaN(tempDay) || tempDay < 1 || tempDay > 31)
      return true

    validateDate = (year, month, day)->
      tempDay = parseInt(day)
      tempMonth = parseInt(month)
      tempYear = parseInt(year)
      return false if (isNaN(tempDay) || isNaN(tempMonth) || isNaN(tempYear) )
      return false if(tempDay < 1 || tempDay > 31)
      if(tempMonth is 4 || tempMonth is 6 || tempMonth is 9 || tempMonth is 11)
        if(tempDay < 1 || tempDay > 30)
          return false
      if(tempMonth is 2)
        remainder = year%4
        if(remainder is 0)
          if(tempDay < 1 || tempDay > 29)
            return false
        else
          if(tempDay < 1 || tempDay > 28)
            return false
      return true

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

    checkPostCode = (data, key)->
      return null unless data.attributes[key].postCode
      re = /^\d{5,6}(?:[-\s]\d{4})?$/
      return null if re.test(data.values[key])
      return {key:key, msg:"Invalid post code"}

    checkPostalAddress = (data, key)->
      return null unless data.attributes[key].postalAddress
      re = /[a-zA-Z\d\s\-\,\#\.\+]+/
      return null if re.test(data.values[key])
      return {key:key, msg:"Invalid postal address"}

    checkIPAddress = (data, key)->
      return null unless data.attributes[key].ipAddress
      re = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/
      return null if re.test(data.values[key])
      return {key:key, msg:"Invalid IP address"}

    checkCreditCard = (data, key)->
      return null unless data.attributes[key].creditCard
      re = /^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$/
      return null if re.test(data.values[key])
      return {key:key, msg:"Invalid credit card number"}

    checkRequired = (data, key)->
      return null unless data.attributes[key]?.required
      return {key:key,msg:generateKeyWords(key)+" is required"} unless data.values[key]
      return null

    checkType = (data,key)->
      return null unless data.attributes[key].type
      if (result = checkNumber(data,key)) then return result
      if (result = checkBoolean(data,key)) then return result
      if (result = checkDate(data,key)) then return result
      if (result = checkDD(data,key)) then return result
      if (result = checkMM(data,key)) then return result
      if (result = checkYYYY(data,key)) then return result
      return null

    checkNumber = (data, key, force)->
      unless force
        return null unless data.attributes[key].type is 'number'
      return null if !isNaN(data.values[key])
      return {key:key,msg:generateKeyWords(key)+' should be number'}

    checkDD = (data,key)->
      return null unless data.attributes[key].type is 'dd'
      data.attributes[key].maxLength = 2
      if (result = checkNumber(data,key, true)) then return result
      if (result = checkMaxLength(data,key)) then return result
      unless validateDay(data.values[key]) then return {key:key,msg:generateKeyWords(key)+'is not valid'}
      return null

    checkMM = (data,key)->
      return null unless data.attributes[key].type is 'mm'
      data.attributes[key].maxLength = 2
      if (result = checkNumber(data,key,true)) then return result
      if (result = checkMaxLength(data,key)) then return result
      unless validateMonth(data.values[key]) then return {key:key,msg:generateKeyWords(key)+'is not valid'}
      return null

    checkYYYY = (data,key)->
      return null unless data.attributes[key].type is 'yyyy'
      data.attributes[key].maxLength = 4
      data.attributes[key].minLength = 4
      if (result = checkNumber(data,key, true)) then return result
      if (result = checkMaxLength(data,key)) then return result
      if (result = checkMinLength(data,key)) then return result
      unless validateYear(data.values[key]) then return {key:key,msg:generateKeyWords(key)+'is not valid'}
      return null

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
      return {key:key, msg:generateKeyWords(key)+" is not a valid date"} unless validateDateString(data.values[key])
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

    generateAttributes = (modelName, keys)->
      model = _modelsAttributes[modelName]
      attributes = {}
      for key in keys
        attributes[key] = model[key]
      attributes

    service