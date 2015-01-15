define [
  'angular'
  'angular_resource'
], (angular) ->
  appModule = angular.module 'common.constants', []
  appModule.factory "Constants", () ->
    service = {}

    service.POS_STEP = 2

    service
