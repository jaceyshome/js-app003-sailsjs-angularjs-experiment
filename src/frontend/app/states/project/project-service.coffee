define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.project.service', []
  appModule.factory "ProjectService", ($http, $q, CSRF, $rootScope, MessageService, $state,$sailsSocket) ->
    #----------------------------------------------------------------------private variables
    _projects = null
    _project = null

    #--------------------------------------------------------------------- socket services
    $sailsSocket.subscribe('project',(data)->
      console.log "project msg", data
    )

    $sailsSocket.get('/project/subscribe').success(()->
      console.log "get project subscribe"
    )


    #----------------------------------------------------------------------public variables
    service = {}

    #----------------------------------------------------------------------public functions
    service.goToDefault = ()->
      $state.go '/'

    service.getProject = ()->
      _project

    service.setProject = (project)->
      _project = project

    service.listProjects = ()->
      deferred = $q.defer()
      if _projects
        deferred.resolve _projects
      else
        $http.get("#{config.baseUrl}/project/all")
        .then (result) ->
          _projects = result.data
          deferred.resolve result.data
        .catch (err)->
          deferred.resolve null
          handleErrorMsg(err)
      deferred.promise

    service.createProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        project._csrf = data._csrf
#        newProject =
#          name: project.name
#          _csrf: data._csrf
        $http.post("#{config.baseUrl}/project/create", project)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.getProjectDetail = (project)->
      deferred = $q.defer()
      deferred.resolve project if angular.equals project, _project
      $http.get("#{config.baseUrl}/project/specifics/#{project.shortLink}")
      .then (result) ->
        deferred.resolve result.data
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.updateProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        editingProject =
          id: project.id
          shortLink: project.shortLink
          name: project.name
          description: project.description
          _csrf: data._csrf
        $http.put("#{config.baseUrl}/project/update", editingProject)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
        deferred.promise

    service.destroyProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        deletingProject =
          id: project.id
          shortLink: project.shortLink
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/project/destroy", deletingProject)
        .then (result) ->
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

  #-------------------------------------------------------------------handlers
    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
