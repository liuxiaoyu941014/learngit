class RoomChannel
  constructor: (@id, @name, credential)->
    throw '请先执行 RoomChannel.connect(credential) 建立连接' unless RoomChannel.cable?
    @subscription = RoomChannel.cable.subscriptions.create { channel: "RoomChannel", id: @id },
      connected: => @connected()
      disconnected: => @disconnected()
      received: (data)=> @received(data)
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log("room", @id, @name, 'connected')

  disconnected: =>
    # Called when the subscription has been terminated by the server
    console.log("room", @id, @name, 'disconnected')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log("room", @id, @name, 'received', data)
  say: (message) ->
    # @subscription.send message: message
    @subscription.perform 'say', message: message

  this.connect = (credential) ->
    @cable = ActionCable.createConsumer("/cable?credential=#{credential}")
  # static methods
  this.switch = (id, name) ->
    return if @current && id == @current.id
    @leave()
    @enter id, name
  this.enter = (id, name) ->
    console.log('enter room ' + id + ':' + name)
    @current = new RoomChannel(id, name)
  this.leave = ->
    return unless @current
    console.log('leave room ' + @current.id + ':' + @current.name)
    @current.subscription.unsubscribe()
    delete @current


App.RoomChannel = RoomChannel
