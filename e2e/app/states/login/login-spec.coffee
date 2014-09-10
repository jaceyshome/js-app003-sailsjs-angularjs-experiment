should = require "should"
Page = require './login-page'
HttpBackend = require "../../../mocks/session-mock"

describe "login", ->
  ptor = protractor.getInstance()
  path = "#{browser.params.app}/login"
  ptor.addMockModule('httpBackendMock', HttpBackend.sessionBackEnd)
  page = new Page.LoginPage()

  beforeEach ->
    page.reset()

  afterEach ->

  it "should redirect to login page from other place, if not login", ->
    browser.get path

  it "should show password error, if password is empty", ->
    browser.get path

  it "should show username error, if username is empty", ->
    browser.get path

  it "should login the app, if user name and password are correct", ->
    browser.get path
    page.setUserName 'username'
    page.setPassword '123'
    page.login()
    #TODO error message panel

  it "should redirect to home page, if user already login", ->
    browser.get path



