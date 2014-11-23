userBackEnd = ()->
  angular.module('httpBackendMock', ['ngMockE2E', 'app']).run ($httpBackend)->
    $httpBackend.whenPOST("/user/create").respond((method,url,data, headers)->
      user = angular.fromJson(data)
      return [200, user]
    )

module.exports.userBackEnd = userBackEnd