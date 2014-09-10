# Page object
class LoginPage
  constructor: ->
    @userName = element(By.model 'user.name')
    @password = element(By.model 'user.password')
    @loginButton = element(By.css '[data-ng-click="handleSumbit()"]')
    @error = element `by`.model 'loginError'

  get: ->
    browser.get '/#/login'
    browser.getCurrentUrl()

  setUserName: (text) ->
    @userName.clear()
    @userName.sendKeys text
    @

  clearUserName: ->
    @email.clear()
    @

  setPassword: (text) ->
    @password.clear()
    @password.sendKeys text
    @

  clearPassword: ->
    @password.clear()
    @

  login: ->
    @loginButton.click()
    @

  getErrorText: ->
    @error.getText()

  reset: ->
    @userName.clear()
    @password.clear()
    @

module.exports.LoginPage = LoginPage