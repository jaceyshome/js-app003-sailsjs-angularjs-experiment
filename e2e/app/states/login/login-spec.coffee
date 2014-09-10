should = require "should"
Page = require './login-page'
HttpBackend = require "../../../mocks/session-mock"

describe "login", ->
  ptor = protractor.getInstance()
  path = "#{browser.params.app}/login"
  ptor.addMockModule('httpBackendMock', HttpBackend.sessionBackEnd)
  page = new Page.LoginPage()
#  ptor = protractor.getInstance()
#
  beforeEach ->
    #ptor.driver.get browser.params.mock

  afterEach ->
#    ptor.driver.get browser.params.clean

  it "should show a login error,if user name is wrong", ->

  it "should show a login error if user password is wrong", ->

  it "should login the app, if user name and password are correct", ->
    browser.get path
    page.setUserName 'username'
    page.setPassword '123'
    page.login()
#    element(By.model 'user.name').sendKeys 'username'
#    element(By.model 'user.password').sendKeys 'password'
#    element(By.css '[data-ng-click="handleSumbit()"]').click()



  it "should already be logged in", ->


