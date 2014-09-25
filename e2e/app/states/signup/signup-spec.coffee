should = require "should"
Page = require './signup-page'
HttpBackend = require "../../../mocks/session-mock"

describe "Signup", ->
  ptor = protractor.getInstance()
  path = "#{browser.params.app}/signup"
  ptor.addMockModule('httpBackendMock', HttpBackend.sessionBackEnd)
  page = new Page.SignupPage()

  beforeEach ->

  afterEach ->

  it "should signup the user, if the username is unique", ->
    browser.get path
    page.setUserName 'username'
    page.setEmail 'username@gmail.com'
    page.setPassword '123'
    page.setConfirmPassword '123'
    page.signup()



