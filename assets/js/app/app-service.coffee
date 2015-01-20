define [
  'angular'
], (angular) ->
  appModule = angular.module 'app.service',[]
  appModule.factory "AppService", (Constants) ->
    #Rules:  It is used for business logic and rules, should not be long
    service = {}

    service.updatePos = (item,items)->
      index = items.indexOf item
      if index is 0 and items.length is 1                     #first one
        item.pos = Constants.POS_INITIATION_VALUE
      else if index is 0 and items.length > 1
        item.pos = (items[index+1].pos - Constants.POS_STEP)
      else if (index + 1) is items.length                     #last one
        item.pos = (items[index-1].pos + Constants.POS_STEP)
      else                                                    #in the middle
        item.pos = (items[index-1].pos + (items[index+1].pos - items[index-1].pos) / 2)
      return item

    service
