define(['angular'], function(angular) {
  var appModule;
  appModule = angular.module('app.service', []);
  return appModule.factory("AppService", function(Constants) {
    var service;
    service = {};
    service.updatePos = function(item, items) {
      var index;
      index = items.indexOf(item);
      if (index === 0 && items.length === 1) {
        item.pos = Constants.POS_INITIATION_VALUE;
      } else if (index === 0 && items.length > 1) {
        item.pos = items[index + 1].pos - Constants.POS_STEP;
      } else if ((index + 1) === items.length) {
        item.pos = items[index - 1].pos + Constants.POS_STEP;
      } else {
        item.pos = items[index - 1].pos + (items[index + 1].pos - items[index - 1].pos) / 2;
      }
      return item;
    };
    return service;
  });
});

//# sourceMappingURL=app-service.js.map
