define(['angular', 'common/validation/attribute-models'], function(angular, attributeModels) {
  var module;
  module = angular.module('common.validation', []);
  return module.factory('Validation', function() {
    var ConvertStringToBoolean, checkBoolean, checkDate, checkDateString, checkEmail, checkMatchingField, checkMaxLength, checkMinLength, checkNumber, checkRequired, checkType, generateAttributes, generateKeyWords, service;
    console.log("validation data", attributeModels);
    service = {};
    service.getModelAttributes = function(modelName, keys) {
      if (!(modelName || attributeModels[modelName])) {
        return null;
      }
      if (keys && attributeModels[modelName]) {
        return generateAttributes(modelName, keys);
      }
      return angular.copy(data[modelName]);
    };
    service.validate = function(data) {
      var key, result;
      result = null;
      for (key in data.attributes) {
        if (data.attributes.hasOwnProperty(key)) {
          if ((result = checkRequired(data, key))) {
            return result;
          }
          if ((result = checkType(data, key))) {
            return result;
          }
          if ((result = checkEmail(data, key))) {
            return result;
          }
          if ((result = checkMaxLength(data, key))) {
            return result;
          }
          if ((result = checkMinLength(data, key))) {
            return result;
          }
          if ((result = checkMatchingField(data, key))) {
            return result;
          }
        }
      }
      return result;
    };
    service.validateDate = function(day, month, year) {
      var remainder, tempDay, tempDob, today;
      tempDay = parseInt(day);
      if (isNaN(tempDay) || tempDay < 1 || tempDay > 31) {
        return false;
      }
      if (month === 4 || month === 6 || month === 9 || month === 11) {
        if (tempDay < 1 || tempDay > 30) {
          return false;
        }
      }
      if (month === 2) {
        remainder = year % 4;
        if (remainder === 0) {
          if (tempDay < 1 || tempDay > 29) {
            return false;
          }
        } else {
          if (tempDay < 1 || tempDay > 28) {
            return false;
          }
        }
      }
      tempDob = new Date();
      tempDob.setFullYear(day, month, year);
      today = new Date();
      if (tempDob > today) {
        return false;
      }
      return true;
    };
    service.validateMonth = function(month) {
      var tempMonth;
      if (month.length < 1 || month.length > 2) {
        return false;
      }
      tempMonth = parseInt(month);
      if (isNaN(tempMonth) || tempMonth < 1 || tempMonth > 12) {
        return false;
      }
      return true;
    };
    service.validateYear = function(year) {
      if (year.length !== 4) {
        return false;
      }
      if (isNaN(year)) {
        return false;
      }
      return true;
    };
    service.validateDateString = function(date) {
      var data;
      if (!checkDateString(date)) {
        return false;
      }
      data = date.split('-');
      if (data.length !== 3) {
        data = date.split('/');
        if (data.length !== 3) {
          return false;
        }
      }
      return service.validateYear(data[2]) && service.validateMonth(data[1]) && service.validateDate(data[0], data[1], data[2]);
    };
    checkDateString = function(date) {
      var pattern;
      pattern = new RegExp("[^-/0123456789]");
      if (!date.match(pattern)) {
        return true;
      } else {
        return false;
      }
    };
    generateAttributes = function(modelName, keys) {
      var attributes, key, model, _i, _len;
      model = attributeModels[modelName];
      attributes = {};
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        key = keys[_i];
        attributes[key] = model[key];
      }
      return attributes;
    };
    checkMaxLength = function(data, key) {
      if (!data.attributes[key].maxLength) {
        return null;
      }
      if (data.values[key].length > data.attributes[key].maxLength) {
        return {
          key: key,
          msg: generateKeyWords(key) + " max length is " + data.attributes[key].maxLength
        };
      } else {
        return null;
      }
    };
    checkMinLength = function(data, key) {
      if (!data.attributes[key].minLength) {
        return null;
      }
      if (data.values[key].length < data.attributes[key].minLength) {
        return {
          key: key,
          msg: generateKeyWords(key) + " miniumn length is " + data.attributes[key].minLength
        };
      } else {
        return null;
      }
    };
    checkEmail = function(data, key) {
      var re;
      if (!data.attributes[key].email) {
        return null;
      }
      re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if (re.test(data.values[key])) {
        return null;
      }
      return {
        key: key,
        msg: "Invalid email"
      };
    };
    checkRequired = function(data, key) {
      var _ref;
      if (!((_ref = data.attributes[key]) != null ? _ref.required : void 0)) {
        return null;
      }
      if (!data.values[key]) {
        return {
          key: key,
          msg: generateKeyWords(key) + " is required"
        };
      }
      return null;
    };
    checkType = function(data, key) {
      var result;
      if (!data.attributes[key].type) {
        return null;
      }
      if ((result = checkNumber(data, key))) {
        return result;
      }
      if ((result = checkBoolean(data, key))) {
        return result;
      }
      if ((result = checkDate(data, key))) {
        return result;
      }
      return null;
    };
    checkNumber = function(data, key) {
      if (data.attributes[key].type !== 'number') {
        return null;
      }
      if (!isNaN(data.values[key])) {
        return null;
      }
      return {
        key: key,
        msg: generateKeyWords(key) + ' should be number'
      };
    };
    checkBoolean = function(data, key) {
      if (data.attributes[key].type !== 'boolean') {
        return null;
      }
      if (typeof ConvertStringToBoolean(data.values[key]) === 'boolean') {
        return null;
      }
      return {
        key: key,
        msg: generateKeyWords(key) + ' should be boolean true or false'
      };
    };
    ConvertStringToBoolean = function(string) {
      switch (string.toLowerCase()) {
        case "true":
        case "yes":
        case "1":
          return true;
        case "false":
        case "no":
        case "0":
        case null:
          return false;
        default:
          return Boolean(string);
      }
    };
    checkDate = function(data, key) {
      if (data.attributes[key].type !== 'date') {
        return null;
      }
      if (!service.validateDateString(data.values[key])) {
        return {
          key: key,
          msg: generateKeyWords(key) + " is not a valid date"
        };
      }
      return null;
    };
    checkMatchingField = function(data, key) {
      var matchKey;
      if (!data.attributes[key].match) {
        return null;
      }
      matchKey = data.attributes[key].match;
      if (data.values[matchKey] !== data.values[key]) {
        return {
          key: key,
          msg: generateKeyWords(key) + ' does not match ' + generateKeyWords(matchKey)
        };
      } else {
        return null;
      }
    };
    generateKeyWords = function(key) {
      var words;
      words = key.match(/[A-Z]?[a-z]+|[0-9]+/g);
      return words.join(" ").toLowerCase();
    };
    return service;
  });
});

//# sourceMappingURL=validation.js.map
