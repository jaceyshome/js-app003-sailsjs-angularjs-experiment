should = require "should"
describe "login", ->

  ptor = null
  path = "#{browser.params.app}/login"
  
  beforeEach ->
    ptor = protractor.getInstance()
#    ptor.driver.get browser.params.mock

  afterEach ->
#    ptor.driver.get browser.params.clean
    
  it "should show a login error", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'fails'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    alertDialog = browser.switchTo().alert()
    expect(alertDialog.getText()).toEqual "Invalid username or password"
    alertDialog.accept()

  it "should login the app", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'username'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    expect(element(By.css '.dashboard').getText()).toBeDefined()

  it "should login the app via email", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'test@test.com'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    expect(element(By.css '.dashboard').getText()).toBeDefined()

  it "should already be logged in", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'username'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    expect(element(By.css '.dashboard').getText()).toBeDefined()
    browser.get "#{browser.params.app}"
    expect(element(By.css '.dashboard').getText()).toBeDefined()

  it "should got to the register screen", ->
    browser.get path
    element(By.css '[data-ng-click="register()"]').click()
    expect(element(By.css '.title').getText()).toEqual "Register"

  it "should login the app via duplicate email", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'duplicate@test.com'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    element.all(By.repeater 'user in users')
    .then (elements)->
      expect(elements.length).toEqual 2
      element(By.css '[data-ng-click="select(user)"]:nth-child(1)').click()
      expect(element(By.css '.dashboard').getText()).toBeDefined()

  it "should cancel login the app via duplicate email", ->
    browser.get path
    element(By.model 'user.username').sendKeys 'duplicate@test.com'
    element(By.model 'user.password').sendKeys 'password'
    element(By.css '[data-ng-click="login()"]').click()
    element.all(By.repeater 'user in users')
    .then (elements)->
      element(By.css '[data-ng-click="cancel()"]').click()


