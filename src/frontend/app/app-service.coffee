define [
  'angular'
], (angular) ->
  appModule = angular.module 'app.service'
  appModule.factory "AppService", () ->
    service = {}

    service
