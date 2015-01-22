define(['angular', 'angular_resource'], function(angular) {
  var appModule;
  appModule = angular.module('common.constants', []);
  return appModule.factory("Constants", function() {
    var service;
    service = {
      POS_STEP: 2,
      POS_INITIATION_VALUE: 100
    };
    return service;
  });
});

//# sourceMappingURL=constants.js.map
