define(['angular'], function(angular) {
  var appModule;
  appModule = angular.module('app.service', []);
  return appModule.factory("AppService", function(Constants) {
    var service;
    service = {};
    service.updatePos = function(item, items) {
      var index, _items;
      index = items.indexOf(item);
      _items = angular.copy(items);
      if ((index + 1) === items.length) {
        item.pos = _items[index - 1].pos + Constants.POS_STEP;
      } else if (index === 0) {
        item.pos = _items[index + 1].pos - Constants.POS_STEP;
      } else {
        item.pos = _items[index - 1].pos + (_items[index + 1].pos - _items[index - 1].pos) / 2;
      }
      return item;
    };
    return service;
  });
});

//# sourceMappingURL=app-service.js.map
