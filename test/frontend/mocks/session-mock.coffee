sessionBackEnd = ()->
  angular.module('httpBackendMock', ['ngMockE2E', 'app']).run ($httpBackend)->
    $httpBackend.whenPOST("/session/create").respond((method,url,data, headers)->
      user = angular.fromJson(data)
      return [200, user]
    )

module.exports.sessionBackEnd = sessionBackEnd