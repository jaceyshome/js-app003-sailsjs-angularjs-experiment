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
    $sailsSocket.subscribe('user',(data)->
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
      deferred.promise

    service.createProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        newProject =
          name: project.name
          _csrf: data._csrf
        $http.post("#{config.baseUrl}/project/create", newProject)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.getProjectDetail = (project)->
      deferred = $q.defer()
      deferred.promise

    service.updateProject = (project)->
      deferred = $q.defer()
      deferred.promise

    service.destroyProject = (project)->
      deferred = $q.defer()
      deferred.promise

  #-------------------------------------------------------------------handlers
    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
