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

  it "should signup the user", ->
    browser.get path
    page.setUserName 'username'
    page.setEmail 'username@gmail.com'
    page.setPassword '123'
    page.setConfirmPassword '123'
    page.signup()

#  it "name is required, it should show error message if the name is empty", ->
#  it "email is required, it should show error message if the email is empty", ->
#  it "password is required, it should show error message if the password is empty", ->
#  it "confirm password is required, it should show error message if confirm password is empty", ->


#  it "validate the email address, it should show error message if the email address is invaid", ->

#  it "it should show error message if confirm password doesnt match password", ->

