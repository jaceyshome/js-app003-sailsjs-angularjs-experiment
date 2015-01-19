define(['angular', 'angular_resource'], function(angular) {
  var appModule;
  appModule = angular.module('common.constants', []);
  return appModule.factory("Constants", function() {
    var service;
    service = {};
    service.POS_STEP = 2;
    return service;
  });
});

//# sourceMappingURL=constants.js.map
