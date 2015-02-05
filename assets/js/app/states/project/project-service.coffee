define [
  'angular'
  'angular_resource'
  'app/config'
  'lodash'
], (angular,angular_resource, config, _) ->
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

    service.goToDefault = ()->
      $state.go '/'

    #---------------------------- Project services-------------------------------
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

    service.destroyProject = (project)->
      deferred = $q.defer()
      CSRF.get().then (data)->
        $http.delete("#{config.baseUrl}/project/destroy/#{project.id}/s/#{project.shortLink}/?_csrf=#{encodeURIComponent(data._csrf)}")
        .then (result) ->
          return deferred.resolve result.data
        .catch (err)->
          handleErrorMsg(err)
          return deferred.resolve null
      deferred.promise

    service.fetchProject = (project)->
      deferred = $q.defer()
      $http.get("#{config.baseUrl}/project/specify/#{project.id}/s/#{project.shortLink}")
      .then (result) ->
        _project = handleFetchProjectAfter(result.data)
        deferred.resolve _project
      .catch (err)->
        handleErrorMsg(err)
        deferred.resolve null
      deferred.promise

    service.fetchProjects = ()->
      deferred = $q.defer()
      if _projects
        deferred.resolve _projects
      else
        $http.get("#{config.baseUrl}/project/all")
        .then (result) ->
          _projects = result.data
          deferred.resolve _projects
        .catch (err)->
          deferred.resolve null
          handleErrorMsg(err)
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

    #------------------------------ Project handlers ---------------------------------
    handleCreatedProjectAfter = (project)->
      return unless _projects
      if project.id is _projects[project.id]?.id and project.shortLink is _projects[project.id]?.shortLink
        return
      _projects[project.id] = project
      return

    handleFetchProjectAfter = (project)->
      return unless _projects
      if _projects
        _project = _.find(_projects, {'id':project.id})
        return _.merge(_project, formatProject(project))

    formatProject = (project)->
      return unless project?.stages
      return unless project?.tasks
      if project.stages
        stages = _.map project.stages, (_stage)->
          if project.tasks
            _stage.tasks = _.where(project.tasks,{'idStage': _stage.id})
            sortStageTasks(_stage)
            return _stage
      _project =
        stages: stages
      sortProjectStages(_project)
      delete project.tasks
      return _.merge project, _project

    handleUpdatedProjectAfter = (project)->
      return unless _projects
      for proj in _projects
        if proj.id is project.id and proj.shortLink is project.shortLink
          _.merge proj, project
          return

    #------------------------------- Stage services -------------------------------
    service.handleCreatedStageAfter = (stage)->
      _project = _.find(_projects, {'id':stage.idProject})
      _project.stages = [] unless _project.stages
      _stage = _.find(_project.stages, {'id':stage.id})
      unless _stage and _stage.id is stage.id
        _project.stages.push stage
      return sortProjectStages(_project)

    service.handleDestroyedStageAfter = (stageId)->
      return unless stageId
      for _project in _projects
        if _project.tasks
          for task in _project.tasks
            if task?.idStage is stageId
              _project.tasks.splice(_project.tasks.indexOf(task),1)
        stage = _.find(_project.stages, {'id':stageId})
        if stage?.id is stageId
          _project.stages.splice(_project.stages.indexOf(stage),1)

    service.handleUpdatedStageAfter = (stage)->
      _project = _.find(_projects, {'id':stage.idProject})
      unless _project.stages and _project.stages.length > 0
        return sortProjectStages(_project)
      _stage = _.find(_project.stages, {'id':stage.id})
      if _stage.id is stage.id and _stage.idProject is stage.idProject
        _.merge _stage, stage
        return sortProjectStages(_project)

    #------------------------------- Task services --------------------------
    service.handleCreatedTaskAfter = (task)->
      return unless task.idProject
      return unless task.idStage
      _project = _.find(_projects,{'id':task.idProject})
      _stage = _.find(_project.stages,{'id':task.idStage})
      _stage.tasks = [] unless _stage.tasks
      _task = _.find(_stage.tasks,{'id':task.id})
      unless _task
        _stage.tasks.push task
      return sortStageTasks(_stage)

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

    service.handleUpdatedTaskAfter = (task)->
      result = compareUpdatedTaskWithProjectTask(task)
      if result.oldTask
        handleOldTask(result.oldTask)
      if result.newTask
        handleNewTask(result.newTask)
      if result.currentTask
        handleCurrentTask(result.currentTask, task)
      _project = _.find _projects, {'id': task.idProject}
      _stage = _.find _project.stages, {'id':task.idStage}
      sortStageTasks(_stage)
      return

    #------------------------------- Task services helpers --------------------------
    compareUpdatedTaskWithProjectTask = (task)->
      #Define updated task with current task
      _task = null
      result =
        currentTask: null
        oldTask: null
        newTask: null
      for _project in _projects
        continue unless _project.stages and _project.stages.length > 0
        break if _task
        for _stage in _project.stages
          _task = _.find(_stage.tasks, {id:task.id})
          break if _task
      if !angular.equals(_task.idProject, task.idProject) or !angular.equals(_task.idStage,task.idStage)
        result.oldTask = _task
        result.newTask = task
      else
        result.currentTask = _task
      return result

    handleCurrentTask = (currentTask, task)->
      _.merge currentTask, task
      return

    handleNewTask = (newTask)->
      _project = _.find _projects, {'id':newTask.idProject}
      return unless _project
      _stage = _.find _project.stages, {'id':newTask.idStage}
      return unless _stage
      _stage.tasks = [] unless _stage.tasks
      _task = _.find _stage.tasks, {'id': newTask.id}
      _stage.tasks.push newTask unless _task
      return

    handleOldTask = (oldTask)->
      _project = _.find _projects, {'id':oldTask.idProject}
      return unless _project
      _stage = _.find _project.stages, {'id':oldTask.idStage}
      return unless _stage
      _stage.tasks.splice(_stage.tasks.indexOf(oldTask),1)
      return

    #------------------------ General helpers ------------------------------------
    sortProjectStages = (project)->
      return unless project.stages
      project.stages.sort(comparePosAsc)
      return project

    sortStageTasks = (stage)->
      return unless stage.tasks
      stage.tasks.sort(comparePosAsc)

    comparePosAsc = (a, b)->
      if (a.pos < b.pos)
        return -1
      if (a.pos > b.pos)
        return 1
      return 0

    handleErrorMsg = (err)->
      MessageService.handleServerError(err)

  #--------------------------return object ------------------
    service
