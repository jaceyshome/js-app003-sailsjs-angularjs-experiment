# Page object
class SignupPage
  constructor: ->
    @userName = element(By.model 'user.name')
    @email = element(By.model 'user.email')
    @password = element(By.model 'user.password')
    @confirmPassword = element(By.model 'user.confirmPassword')
    @signupButton = element(By.css '[data-ng-click="sumbit()"]')
    @messsage = element `by`.model 'messsage'

  setUserName: (text) ->
    @userName.clear()
    @userName.sendKeys text
    @

  clearUserName: ->
    @userName.clear()
    @

  setEmail: (text) ->
    @email.clear()
    @email.sendKeys text
    @

  clearEmail: ->
    @email.clear()
    @

  setPassword: (text) ->
    @password.clear()
    @password.sendKeys text
    @

  clearPassword: ->
    @password.clear()
    @

  setConfirmPassword: (text) ->
    @confirmPassword.clear()
    @confirmPassword.sendKeys text
    @

  clearConfirmPassword: ->
    @confirmPassword.clear()
    @

  signup: ->
    @signupButton.click()
    @

  getErrorText: ->
    @message.getText()

  reset: ->
    @userName.clear()
    @email.clear()
    @password.clear()
    @confirmPassword.clear()
    @

module.exports.SignupPage = SignupPage