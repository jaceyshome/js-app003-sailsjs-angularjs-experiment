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

    service.createProject = (user)->
      deferred = $q.defer()
      deferred.promise

    service.getProjectDetail = (user)->
      deferred = $q.defer()
      deferred.promise

    service.updateProject = (user)->
      deferred = $q.defer()
      deferred.promise

    service.destroyProject = (user)->
      deferred = $q.defer()
      deferred.promise

  #-------------------------------------------------------------------handlers
    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
