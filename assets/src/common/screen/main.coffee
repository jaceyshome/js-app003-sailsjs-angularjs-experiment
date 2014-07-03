define [
  'angular'
  'angular_resource'
  ], ->
  module = angular.module 'common.screen', []
  module.factory 'Screen', (Structure, $state, $rootScope) ->


    service = {}

    $rootScope.$watch ->
      Structure.data.screen if Structure.data?
    , (screen)->
      service.screen = screen

    backScreen = undefined

    service.go = (id)->
      #console.log "Screen.go", id
      lastState = false
      if service.screen
        lastState = service.screen.state
        backScreen = service.screen.id
      for screen in Structure.data.screens
        Structure.data.screen = screen if screen.id is id
      service.screen = Structure.data.screen
      if lastState and lastState is service.screen.state
        $state.reload()
      else
        $state.go Structure.data.screen.state, id

    service.first = ->
      screen = Structure.data.screens[0] unless Structure.data.screen?
      service.go screen.id

    getScreenList = ->
      # Get screens that aren't marked as 'hidden'
      list = []
      for item in Structure.data.screens
        if item.hidden isnt true
          list.push item
      return list

    service.getScreens = ->
      return getScreenList()

    # -----------------------------------------------

    checkIfNextScreen = ->
      return false unless Structure?.data?.screens?
      list = getScreenList()
      index = list.indexOf Structure.data.screen
      if index isnt -1
        index++
        if index < list.length
          return index
      return -1

    service.hasNext = ->
      if checkIfNextScreen() >= 0
        return true
      else
        return false

    service.next = ->
      index = checkIfNextScreen()
      if index >= 0
        list = getScreenList()
        service.go list[index].id
      else
        console.log "No next screen."

    # -----------------------------------------------

    checkIfPreviousScreen = ->
      return false unless Structure?.data?.screens?
      list = getScreenList()
      index = list.indexOf Structure.data.screen
      if index isnt -1
        index--
        if index >= 0
          return index
      return -1

    service.hasPrevious = ->
      if checkIfPreviousScreen() >= 0
        return true
      else
        return false

    service.previous = ->
      index = checkIfPreviousScreen()
      if index >= 0
        list = getScreenList()
        service.go list[index].id
      else
        console.log "No previous screen."

    # -----------------------------------------------

    checkIfBackScreen = ->
      return false unless Structure?.data?.screens?
      if backScreen?
        return backScreen
      return -1

    service.hasBack = ->
      if checkIfBackScreen() != -1
        return true
      else
        return false

    service.back = ->
      id = checkIfBackScreen()
      if id != -1
        service.go id
      else
        console.log "No last viewed screen."

    # -----------------------------------------------

    service.getScreenData = (id)->

    return service

