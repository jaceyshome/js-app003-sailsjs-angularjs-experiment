define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config) ->
  appModule = angular.module 'app.states.stage.service', []
  appModule.factory "StageService", ($http, $q, CSRF, $rootScope, MessageService, $state,$sailsSocket, ProjectService) ->
    #------------------------------------------------------------------ private variables

    #------------------------------------------------------------------ socket services
    $sailsSocket.subscribe('stage',(res)->
      console.log "stage msg", res
      handleCreatedStageAfter(res.data) if res.verb is 'created'
      handleUpdatedStageAfter(res.data) if res.verb is 'updated'
      handleDestroyedStageAfter(res.id) if res.verb is 'destroyed'
    )

    $sailsSocket.get('/stage/subscribe').success(()->
      console.log "get stage subscribe"
    )

    service = {}

    #------------------------------------------------------------------- public functions
    service.goToDefault = ()->
      $state.go '/'

    service.fetchStages = ()->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/stage/all")
      .then (result) ->
        deferred.resolve result.data
      .catch (err)->
        deferred.resolve null
        handleErrorMsg(err)
      deferred.promise

    service.createStage = (stage)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        stage._csrf = data._csrf
        $http.post("#{config.baseUrl}/stage/create", stage)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.fetchStage = (stage)->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/stage/specify/#{stage.id}/s/#{stage.shortLink}")
      .then (result) ->
        deferred.resolve handleGetStageDetailAfter(result.data)
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.updateStage = (stage)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        stage._csrf = data._csrf
        $http.put("#{config.baseUrl}/stage/update", stage)
        .then (result) ->
          handleUpdatedStageAfter(result.data)
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
        deferred.promise

    service.destroyStage = (stage)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        stage._csrf = data._csrf
        $http.post("#{config.baseUrl}/stage/destroy", stage)
        .then (result) ->
          handleDestroyedStageAfter(stage.id)
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

    #-------------------------------------------------------------------handlers
    handleUpdatedStageAfter = (stage)->
      ProjectService.handleUpdatedStageAfter(stage)

    handleCreatedStageAfter = (stage)->
      ProjectService.handleCreatedStageAfter(stage)

    handleDestroyedStageAfter = (stageId)->
      ProjectService.handleDestroyedStageAfter(stageId)

    handleGetStageDetailAfter = (project)->
      return unless _projects
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          angular.extend proj, project
          return proj

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

    #-----------------------------------------------------------------------return object
    service
