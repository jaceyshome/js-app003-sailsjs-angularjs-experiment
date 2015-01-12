define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config) ->
  appModule = angular.module 'app.states.project.service', []
  appModule.factory "ProjectService", ($http, $q, CSRF, $rootScope, MessageService, $state,$sailsSocket) ->
    #------------------------------------------------------------------ private variables
    _projects = null #All projects data should be saved here

    #------------------------------------------------------------------ socket services
    $sailsSocket.subscribe('project',(res)->
      console.log "project msg", res
      handleCreatedProjectAfter(res.data) if res.verb is 'created'
      handleUpdatedProjectAfter(res.data) if res.verb is 'updated'
    )

    $sailsSocket.get('/project/subscribe').success(()->
      console.log "get project subscribe"
    )

    service = {}

    #------------------------------------------------------------------- public functions
    service.goToDefault = ()->
      $state.go '/'

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
          _projects.push result.data
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.specifyProject = (project)->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/project/specify/#{project.id}/s/#{project.shortLink}")
      .then (result) ->
        deferred.resolve handleGetProjectDetailAfter(result.data)
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
          handleUpdatedProjectAfter(result.data)
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

    service.handleUpdatedStageAfter = (stage)->
      for proj in _projects
        if proj.id is stage.idProject
          return unless proj.stages and proj.stages.length > 0
          for _stage in proj.stages
            if _stage.id is stage.id and _stage.idProject is stage.idProject
              angular.extend _stage, stage
              return

    service.handleCreatedStageAfter = (stage)->
      for proj in _projects
        if proj.id.toString() is stage.idProject.toString() #TODO  currently is for testing on sails disk
          proj.stages = [] unless proj.stages
          for _sg in proj.stages
            if _sg.id is stage.id and _sg.idProject is stage.idProject
              return
          proj.stages.push stage
          return

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

    handleGetProjectDetailAfter = (project)->
      return unless _projects
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          angular.extend proj, project
          return proj

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
