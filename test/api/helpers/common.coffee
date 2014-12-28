CSRF = require("./csrf")
request = require("supertest")

module.exports = (->
  service = {}
  user =
    name: 'test'
    email: 'test@test.com'
    password: 'password'

  project =
    name: 'test project'
    description: 'test project description'

  #--------------------------------- public  functions-----------------------------
  service.getUserInstance = ()->
    return JSON.parse(JSON.stringify(user))

  service.getProjectInstance = ()->
    return JSON.parse(JSON.stringify(project))

  service.createUser = (cb)->
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

  service.createProject = (cb)->
    CSRF.get().then (_csrfRes)->
      _project = JSON.parse(JSON.stringify(project))
      _project._csrf = _csrfRes.body._csrf
      request(sails.hooks.http.app)
      .post('/project/create')
      .set('cookie', _csrfRes.headers['set-cookie'])
      .send(_project)
      .expect(200)
      .end (err, res)->
        if (err) then throw err
        project = res.body
        if cb then cb(res.body)

  service
)()
