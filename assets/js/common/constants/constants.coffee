define [
  'angular'
  'angular_resource'
], (angular) ->
  appModule = angular.module 'common.constants', []
  appModule.factory "Constants", () ->
    service =
      POS_STEP: 2
      POS_INITIATION_VALUE: 100

    service
