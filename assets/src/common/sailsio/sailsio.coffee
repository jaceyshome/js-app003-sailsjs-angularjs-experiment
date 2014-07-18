define [
  'angular'
  'angular_resource'
  'app/config'
], (angular) ->
  appModule = angular.module 'common.sailsio', []
  appModule.factory "SailsIo", ($rootScope, $http, $timeout, $location, $log) ->

    #----------------------------------------------------------------private variables
    optionDefaults =
      url: $location.path()
      defaultScope: $rootScope
      eventPrefix: 'sailsSocket:'
      eventForwards: ['connect', 'message', 'disconnect', 'error']
      reconnectionAttempts: Infinity
      reconnectionDelay: (attempt)->
        maxDelay = 10000
        bo = ((Math.pow(2, attempt) - 1) / 2)
        delay = 1000 * bo # 1 sec x backoff amount
        Math.min(delay, maxDelay)

    ###
    Wraps emit for REST requests to Sails socket.io server
    ###
    requestAction = (url, data, cb, method) ->
      socket = this # The angular Sails Socket
      usage = "Usage:\n socket." + (method or "request") + "( destinationURL, dataToSend, fnToCallWhenComplete )"

      # Remove trailing slashes and spaces
      url = url.replace(/^(.+)\/*\s*$/, "$1")

      # If method is undefined, use 'get'
      method = method or "get"
      throw new Error("Invalid or missing URL!\n" + usage)  if typeof url isnt "string"

      # Allow data arg to be optional
      if typeof data is "function"
        cb = data
        data = {}

      # Build to request
      json = angular.toJson(
        url: url
        data: data
      )

      # Send the message over the socket
      socket.emit method, json, afterEmitted = (result) ->
        parsedResult = result
        if result and typeof result is "string"
          try
            parsedResult = angular.fromJson(result)
          catch e
            $log.warn "Could not parse:", result, e
            parsedResult = error:
              message: "Bad response from server"
        cb and cb(parsedResult)
        return

      return
    asyncAngularify = (socket, callback) ->
      (if callback then ->
        args = arguments_
        $timeout (->
          callback.apply socket, args
          return
        ), 0
        return
      else angular.noop)

    addSocketListener = (eventName, callback) ->
      @ioSocket.on eventName, asyncAngularify(@ioSocket, callback)
      return

    removeSocketListener = ->
      @ioSocket.removeListener.apply @ioSocket, arguments_

    service = (options)->
      sailsSocket =
        options: angular.extend({}, optionDefaults, options)
        ioSocket: null
        on: addSocketListener
        addListener: addSocketListener
        off: removeSocketListener
        removeListener: removeSocketListener
        canReconnect: true
        disconnectRetryTimer: null
        request: requestAction
      #
      # REST calls
      #
        get: (url, data, cb) ->
          @request url, data, cb, "get"

        post: (url, data, cb) ->
          @request url, data, cb, "post"

        put: (url, data, cb) ->
          @request url, data, cb, "put"

        delete: (url, data, cb) ->
          @request url, data, cb, "delete"

        emit: (eventName, data, callback) ->
          @ioSocket.emit eventName, data, asyncAngularify(@ioSocket, callback)


      # when socket.on('someEvent', fn (data) { ... }),
      # call scope.$broadcast('someEvent', data)
        forward: (events, scope) ->
          events = [events]  if events instanceof Array is false
          scope = @options.defaultScope  unless scope
          angular.forEach events, ((eventName) ->
            prefixedEvent = @options.eventPrefix + eventName
            forwardBroadcast = asyncAngularify(@ioSocket, (data) ->
              scope.$broadcast prefixedEvent, data
              return
            )
            scope.$on "$destroy", ->
              @ioSocket.removeListener eventName, forwardBroadcast
              return

            @ioSocket.on eventName, forwardBroadcast
            return
          ), this
          return

        disconnect: ->
          @canReconnect = false
          $timeout.cancel @disconnectRetryTimer
          @removeRetryListeners()
          @ioSocket.disconnect()
          return

        connect: (options) ->
          @disconnect()  if @ioSocket
          angular.extend @options, options
          @ioSocket = io.connect(@options.url,
            reconnect: false
          )
          @forward @options.eventForwards
          @canReconnect = true
          @addRetryListeners()
          this


      #
      # Custom retry logic
      #
        addRetryListeners: ->
          @on "disconnect", @onDisconnect
          @on "error", @onError
          @on "connect", @onConnect
          return

        removeRetryListeners: ->
          @off "disconnect", @onDisconnect
          @off "error", @onError
          @off "connect", @onConnect
          return


      # *disconnect* occurs after a connection has been made.
        onDisconnect: ->
          $log.warn "SailsSocket::disconnected"
          attempts = 0
          retry = ->
            return  unless sailsSocket.canReconnect
            sailsSocket.disconnectRetryTimer = $timeout(->

              # Make http request before socket connect, to ensure auth/session cookie
              $log.info "SailsSocket::retrying... ", attempts
              $http.get(sailsSocket.options.url).success((data, status) ->
                sailsSocket.ioSocket.socket.connect()
                return
              ).error (data, status) ->
                if attempts < sailsSocket.options.reconnectionAttempts
                  retry()
                else

                  # send failure event
                  $log.error "SailsSocket::failure"
                  $rootScope.$broadcast sailsSocket.options.eventPrefix + "failure"
                return

              return
            , sailsSocket.options.reconnectionDelay(attempts++))
            return

          retry()  if attempts < sailsSocket.options.reconnectionAttempts
          return


      # *error* occurs when the initial connection fails.
        onError: ->
          $timeout (->
            $log.error "SailsSocket::failure"
            $rootScope.$broadcast sailsSocket.options.eventPrefix + "failure"
            return
          ), 0
          return

        onConnect: ->
          $log.debug "SailsSocket::connected"
          return




    service
