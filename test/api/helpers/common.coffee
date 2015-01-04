CSRF = require("./csrf")
request = require("supertest")
extend = require("extend")

module.exports = (->
  service = {}
  user =
    name: 'test'
    email: 'test@test.com'
    password: 'password'

  project =
    name: 'test project'
    description: 'test project description'

  stage =
    "name": "stage 1",
    "tasks": [
      {
        "name": "task 1.1",
        "items": [
          {name:"task 1.1 item 1"}
          {name:"task 1.1 item 2"}
          {name:"task 1.1 item 3"}
        ]
      },
      {
        "name": "task 1.2",
        "items": [
          {name:"task 1.2 item 1"}
          {name:"task 1.2 item 2"}
          {name:"task 1.2 item 3"}
        ]
      }
    ]

  task =
    name: "task 1.1"
    items: [
      {name:"task 1.1 item 1"}
      {name:"task 1.1 item 2"}
      {name:"task 1.1 item 3"}
    ]

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
        if cb then cb(res.body)

  service.createProjectStage = (cb)->
    service.createProject (project)->
      CSRF.get().then (csrfRes)->
        _project = JSON.parse(JSON.stringify(project))
        data =
          idProject: _project.id
          name: "stage 1"
          _csrf:  csrfRes.body._csrf
        request(sails.hooks.http.app)
        .post('/stage/create')
        .set('cookie', csrfRes.headers['set-cookie'])
        .send(data)
        .expect(200)
        .end (err, res)->
          if (err) then throw err
          if cb then cb(res.body)

  service.createStage = (project,cb)->
    CSRF.get().then (csrfRes)->
      _project = JSON.parse(JSON.stringify(project))
      data =
        idProject: _project.id
        name: "stage 1"
        _csrf:  csrfRes.body._csrf
      request(sails.hooks.http.app)
      .post('/stage/create')
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(data)
      .expect(200)
      .end (err, res)->
        if (err) then throw err
        if cb then cb(res.body)

  service.createTask = (data,cb)->
    unless data
      if cb then return cb null
      return null
    _task = {}
    extend false, _task, task, data
    CSRF.get().then (csrfRes)->
      _task._csrf = csrfRes.body._csrf
      request(sails.hooks.http.app)
      .post('/task/create')
      .set('cookie', csrfRes.headers['set-cookie'])
      .send(_task)
      .expect(200)
      .end (err, res)->
        if (err) then throw err
        if cb then cb(res.body)

  service
)()
