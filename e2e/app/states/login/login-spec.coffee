should = require "should"
Page = require './login-page'
HttpBackend = require "../../../mocks/session-mock"

describe "login", ->
  ptor = protractor.getInstance()
  path = "#{browser.params.app}/login"
  ptor.addMockModule('httpBackendMock', HttpBackend.sessionBackEnd)
  page = new Page.LoginPage()

  beforeEach ->

  afterEach ->

  it "should login the app, if user name and password are correct", ->
    browser.get path
    page.setUserName 'username'
    page.setPassword '123'
    page.login()



