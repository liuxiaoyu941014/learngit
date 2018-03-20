#= require 'action_cable'
subscriber = null
navMessagesVue = null
tableMessagesVue = null
localMessages = []
onReceivedMessage = (data)->
  if data.type == 'notification-message'
    localMessages.unshift JSON.parse data.message
  else if data.type == 'notification-messages'
    localMessages = JSON.parse(data.messages || null) || []
  navMessagesVue.load()
  tableMessagesVue.load() if tableMessagesVue
onConnected = ->
  console.log('connected')
  subscriber.perform('notifications', {})
onDisconnected = ->
  console.log('disconnected')
connect = (events = {}) ->
  channel = 'UserChannel'
  defaultEvents =
    connected: ->
      console.log('debug', 'my cable connected')
    disconnected: ->
      console.log('debug', 'my cable disconnected')
    rejected: ->
      console.log('debug', 'my cable rejected')
    received: (payload) ->
      console.log('debug', 'my cable received: ', payload)
  cable = window.ActionCable.createConsumer('/cable')
  cable.subscriptions.create({channel}, Object.assign({}, defaultEvents, events))
removeItem = (item, index)->
  localMessages.splice(index, 1)
  navMessagesVue.load()
  tableMessagesVue.load() if tableMessagesVue
  $.ajax
    url: '/agent/messages/'+item.id
    type: 'PATCH'
    success: (data)->
      if data.status == 'ok'
        console.log 'ok'
      else
        $.gritter.add({type: 'error', title: '错误', text: "消息更新失败!"})
        location.reload(true)
    error: (data)->
      $.gritter.add({type: 'error', title: '错误', text: "消息更新失败!"})
      location.reload(true)
redirectTo = (item, index)->
  removeItem(item, index)
  switch item.target_type
    when 'Order'
      window.location.href = "/agent/orders/"+item.target_id

$ ->
  # 连接
  if !subscriber
    subscriber = connect({
      disconnected: onDisconnected,
      connected: onConnected,
      received: onReceivedMessage
    })
  # head nav message vue
  navMessagesVue = new Vue
    name: 'pushMessages'
    el: '.nav-head-push-messages'
    data:
      messages: []
    methods:
      load: ->
        this.messages = localMessages
      removeItem: (item, index)->
        removeItem(item, index)
      redirectTo: (item, index) ->
        redirectTo(item, index)
    mounted: ->
      this.load()
  # table list message vue
  pages = $('.agent-messages.index')
  if pages.length > 0
    container = pages.find('.table-push-messages')
    tableMessagesVue = new Vue
      name: 'TableMessages'
      el: container[0]
      data:
        messages: []
      methods:
        load: ->
          this.messages = localMessages
        removeItem: (item, index)->
          removeItem(item, index)
        redirectTo: (item, index) ->
          redirectTo(item, index)
      mounted: ->
        this.load()
