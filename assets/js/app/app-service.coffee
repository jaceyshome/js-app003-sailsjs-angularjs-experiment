define [
  'angular'
], (angular) ->
  appModule = angular.module 'app.service',[]
  appModule.factory "AppService", (Constants) ->
    #Rules:  It is used for business logic and rules, should not be long
    service = {}

    service.updatePos = (item,items)->
      index = items.indexOf item
      _items = angular.copy items
      if (index + 1) is items.length
        item.pos = (_items[index-1].pos + Constants.POS_STEP)
      else if index is 0
        item.pos = (_items[index+1].pos - Constants.POS_STEP)
      else
        item.pos = (_items[index-1].pos + (_items[index+1].pos - _items[index-1].pos) / 2)
      return item

    service
