HelloController = require('../../api/controllers/HelloController')
sinon = require('sinon')
assert = require('assert')

describe "The Hello Controller", ->
  describe "when we invoke the index action", ->
    it "should return hello world message", ->
      # Mocking res.send() method by using a sinon spy
      send = sinon.spy()
      # Executes controller action
      HelloController.index null,
        send: send
      # Asserts send() method was called and that it was called
      # with the correct arguments: 'Hello World'
      assert send.called
      assert send.calledWith("Hello World")
      return

    return

  return