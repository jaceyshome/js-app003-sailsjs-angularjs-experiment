define(['angular', 'angular_resource', 'app/config'], function(angular) {
  var appModule;
  appModule = angular.module('common.message.service', ['toaster']);
  return appModule.factory("MessageService", function(toaster) {
    var getServerDefaultError, handleDuplicateEntry, handleErrorMsg, handlerValidationError, service;
    service = {};
    service.handleServerError = function(err) {
      var error, msg, _i, _len, _ref, _ref1;
      msg = '';
      if (((_ref = err.data) != null ? _ref.errors : void 0) != null) {
        _ref1 = err.data.errors;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          error = _ref1[_i];
          if (typeof error === 'string') {
            msg += handleErrorMsg(error);
          }
          if (error.ValidationError) {
            msg += handlerValidationError(error.ValidationError);
          }
        }
      } else {
        msg += getServerDefaultError();
      }
      service.showError(msg);
    };
    service.showError = function(msg) {
      return toaster.pop('error', "server error", msg);
    };
    service.handleServerDefaultError = function() {
      return toaster.pop('error', "server error", getServerDefaultError());
    };
    getServerDefaultError = function() {
      return "Internal Server Error, please try again";
    };
    handlerValidationError = function(error) {
      return getServerDefaultError();
    };
    handleErrorMsg = function(err) {
      var msg;
      msg = "";
      if (err.indexOf('ER_DUP_ENTRY') !== -1) {
        msg += handleDuplicateEntry(err);
      }
      return msg;
    };
    handleDuplicateEntry = function(err) {
      var key, strings, value;
      strings = err.match(/(['"])[^'"]*\1/g);
      value = strings[0];
      key = strings[1].split('_')[0].replace('\'', '');
      return key + ":" + value + " already exists";
    };
    return service;
  });
});

//# sourceMappingURL=message.js.map
