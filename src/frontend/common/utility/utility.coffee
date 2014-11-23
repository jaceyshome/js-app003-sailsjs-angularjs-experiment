define [
  'angular'
], (angular) ->
  appModule = angular.module 'common.utility', []
  appModule.factory "Utility", () ->
    service = {}

    service
