should = require "should"
describe "login", ->
  ptor = null
  path = "#{browser.params.app}/login"
  httpBackendMock = ()->
    angular.module('httpBackendMock', ['ngMockE2E', 'app']).run ($httpBackend)->
      $httpBackend.whenPOST("/session/create").respond((method,url,data, headers)->
        user = angular.fromJson(data)
        return [200, user]
      )
  ptor = protractor.getInstance()
  ptor.addMockModule('httpBackendMock', httpBackendMock)
#  ptor = protractor.getInstance()
#
  beforeEach ->
    #ptor.driver.get browser.params.mock

  afterEach ->
#    ptor.driver.get browser.params.clean
    
  it "should show a login error", ->


  it "should login the app", ->
    browser.get path
    element(By.model 'user.name').sendKeys 'username'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="handleSumbit()"]').click()


  it "should already be logged in", ->


