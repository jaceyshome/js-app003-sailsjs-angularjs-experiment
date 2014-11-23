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

  it "should redirect to home page if login succeeds", ->
    browser.get path
    page.setUserName 'username'
    page.setPassword '123'
    page.login()

  it "should show server message if the username is incorrect", ->
    browser.get path
    page.setUserName 'username1'
    page.setPassword '123'
    page.login()

  it "should show server message if the password is incorrect", ->
    browser.get path
    page.setUserName 'username'
    page.setPassword '11'
    page.login()

  it "should show error message if name is empty", ->
    browser.get path
    page.setPassword '123'
    page.login()

  it "should show error message if password is empty", ->
    browser.get path
    page.setUserName 'username'
    page.login()


