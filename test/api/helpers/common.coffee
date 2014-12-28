CSRF = require("./csrf")
request = require("supertest")

module.exports = (->
  service = {}
  user =
    name: 'test'
    email: 'test@test.com'
    password: 'password'

  #--------------------------------- public  functions-----------------------------
  service.getTestUser = ()->
    return JSON.parse(JSON.stringify(user))

  service.createTestUser = (cb)->
    CSRF.get().then (_csrfRes)->
      _user = JSON.parse(JSON.stringify(user))
      _user._csrf = _csrfRes.body._csrf
      request(sails.hooks.http.app)
      .post('/user/create')
      .set('cookie', _csrfRes.headers['set-cookie'])
      .send(_user)
      .expect(200)
      .end (err, res)->
        if (err) then throw err
        if cb then cb(res.body)

  service
)()
