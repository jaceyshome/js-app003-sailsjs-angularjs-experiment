define [
  'angular'
  'angular_resource'
  'app/config'
], (angular,angular_resource, config) ->
  appModule = angular.module 'app.states.task.service', []
  appModule.factory "TaskService", ($http, $q, CSRF, $rootScope, MessageService, $state, $sailsSocket, ProjectService, StageService) ->
    #------------------------------------------------------------------ private variables

    #------------------------------------------------------------------ socket services
    $sailsSocket.subscribe('task',(res)->
      console.log "task msg", res
      handleCreatedTaskAfter(res.data) if res.verb is 'created'
      handleUpdatedTaskAfter(res.data) if res.verb is 'updated'
      handleDestroyedTaskAfter(res.id) if res.verb is 'destroyed'
    )

    $sailsSocket.get('/task/subscribe').success(()->
      console.log "get task subscribe"
    )

    service = {}

    #------------------------------------------------------------------- public functions
    service.goToDefault = ()->
      $state.go '/'

    service.fetchTasks = ()->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/task/all")
      .then (result) ->
        deferred.resolve result.data
      .catch (err)->
        deferred.resolve null
        handleErrorMsg(err)
      deferred.promise

    service.createTask = (task)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        task._csrf = data._csrf
        $http.post("#{config.baseUrl}/task/create", task)
        .then (result) ->
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
      deferred.promise

    service.fetchTask = (task)->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/task/specify/#{task.id}/sg/#{task.idStage}/p/#{task.idProject}")
      .then (result) ->
        deferred.resolve handleGetTaskDetailAfter(result.data)
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.updateTask = (task)->
      return unless task.id
      deferred = $q.defer()
      _task = JSON.parse(JSON.stringify(task))
      delete _task.id
      CSRF.get().then (data)->
        _task._csrf = data._csrf
        $http.put("#{config.baseUrl}/task/update/#{task.id}", _task)
        .then (result) ->
          angular.extend task, result
          deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          deferred.resolve null
        deferred.promise

    service.destroyTask = (task)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        task._csrf = data._csrf
        $http.delete("#{config.baseUrl}/task/destroy/#{task.id}")
        .then (result) ->
          handleDestroyedTaskAfter(task.id)
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

    #-------------------------------------------------------------------handlers
    handleCreatedTaskAfter = (task)->
      ProjectService.handleCreatedTaskAfter(task)

    handleUpdatedTaskAfter = (task)->
      ProjectService.handleUpdatedTaskAfter(task)

    handleDestroyedTaskAfter = (taskId)->
      ProjectService.handleDestroyedTaskAfter(taskId)

    handleGetTaskDetailAfter = (project)->
      #TODO handleGetTaskDetailAfter
      return

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

    #-----------------------------------------------------------------------return object
    service

