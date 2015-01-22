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

    service.fetchProjects = ()->
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

    service.fetchProject = (project)->
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
          return handleSortProjectStages(proj) unless proj.stages and proj.stages.length > 0
          for _stage in proj.stages
            if _stage.id is stage.id and _stage.idProject is stage.idProject
              angular.extend _stage, stage
              return handleSortProjectStages(proj)

    service.handleCreatedStageAfter = (stage)->
      for proj in _projects
        if proj.id.toString() is stage.idProject.toString()
          proj.stages = [] unless proj.stages
          for _sg in proj.stages
            if _sg.id is stage.id and _sg.idProject is stage.idProject
              return handleSortProjectStages(proj)
          proj.stages.push stage
          return handleSortProjectStages(proj)

    service.handleDestroyedStageAfter = (stageId)->
      return unless stageId
      for proj in _projects
        for task in proj.tasks
          if task?.idStage is stageId
            proj.tasks.splice(proj.tasks.indexOf(task),1)
        for stage in proj.stages
          if stage?.id is stageId
            proj.stages.splice(proj.stages.indexOf(stage),1)

    service.handleCreatedTaskAfter = (task)->
      for proj in _projects
        if proj.id.toString() is task.idProject.toString()
          return unless proj.stages
          for stage in proj.stages
            if stage.id is task.idStage and proj.id is stage.idProject
              stage.tasks = [] unless stage.tasks
              for _task in stage.tasks
                if( _task.id is task.id and
                    _task.idStage is task.idStage and
                    _task.idProject is task.idProject)
                  return handleSortStageTasks(stage)
              stage.tasks.push task
              return handleSortStageTasks(stage)

    service.handleUpdatedTaskAfter = (task)->
      handleTaskPos(updateTask(task))

    service.handleDestroyedTaskAfter = (taskId)->
      return unless taskId
      for proj in _projects
        continue unless proj.tasks
        for task in proj.tasks
          if task?.id is taskId
            proj.tasks.splice(proj.tasks.indexOf(task),1)
        continue unless proj.stages
        for stage in proj.stages
          continue unless stage.tasks
          for task in stage.tasks
            if task?.id is taskId
              stage.tasks.splice(stage.tasks.indexOf(task),1)
      return

    #-------------------------------------------------------------------handlers
    updateTask = (task)->
      for proj in _projects
        continue unless proj.tasks
        for _task in proj.tasks
          if _task.id is task.id
            angular.extend _task, task
            return _task

    handleTaskPos = (task)->
      for proj in _projects
        continue unless proj.stages
        for stage in proj.stages
          stage.tasks = [] unless proj.stages
          taskIndex = stage.tasks.indexOf(task)
          if task.idStage is stage.id and taskIndex >= 0
            handleSortStageTasks(stage)
          else if task.idStage is stage.id and taskIndex < 0
            stage.tasks.push task
            handleSortStageTasks(stage)
          else if task.idStage isnt stage.id and taskIndex >= 0
            stage.tasks.splice task,1
            handleSortStageTasks(stage)
      return

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
      formatProjectStagesTasks(project)
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          angular.extend proj, project
          return proj

    formatProjectStagesTasks = (project)->
      return unless project?.stages
      return unless project?.tasks
      for stage in project.stages
        stage.tasks = []
        for task in project.tasks
          if task.idStage.toString() is stage.id.toString()
            stage.tasks.push task

    handleSortProjectStages = (project)->
      project.stages.sort(compareByPos)

    handleSortStageTasks = (stage)->
      stage.tasks.sort(compareByPos)

    compareByPos = (a, b)->
      if (a.pos < b.pos)
        return -1
      if (a.pos > b.pos)
        return 1
      return 0

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #-----------------------------------------------------------------------return object
    service
