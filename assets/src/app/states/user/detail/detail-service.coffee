define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.user.detail.service', []
  appModule.factory "UserDetailService", () ->
    service = {}

    service
