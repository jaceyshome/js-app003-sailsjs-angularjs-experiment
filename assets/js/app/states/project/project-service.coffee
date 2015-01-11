define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config, csrf) ->
  appModule = angular.module 'app.states.project.service', []
  appModule.factory "ProjectService", ($http, $q, CSRF, $rootScope, MessageService, $state,$sailsSocket) ->
    #----------------------------------------------------------------------private variables
    _projects = null

    #--------------------------------------------------------------------- socket services
    $sailsSocket.subscribe('project',(res)->
      console.log "project msg", res
      handleCreatedProjectAfter(res.data) if res.verb is 'created'
      handleUpdatedProjectAfter(res.data) if res.verb is 'updated'
    )

    $sailsSocket.get('/project/subscribe').success(()->
      console.log "get project subscribe"
    )

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
        $http.post("#{config.baseUrl}/project/create", project)
        .then (result) ->
          handleCreatedProjectAfter(result)
          _projects.push result.data
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.getProjectDetail = (project)->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/project/specifics/#{project.id}/s/#{project.shortLink}")
      .then (result) ->
        deferred.resolve result.data
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.updateProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        project._csrf = data._csrf
        $http.put("#{config.baseUrl}/project/update", project)
        .then (result) ->
          handleUpdatedProjectAfter(result)
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
    handleUpdatedProjectAfter = (project)->
      return unless _projects
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          angular.extend proj, project
          return

    handleCreatedProjectAfter = (project)->
      return unless _projects
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          return
      _projects.push project

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
