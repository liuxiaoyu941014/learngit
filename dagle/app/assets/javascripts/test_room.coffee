# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jquery
#= require jquery_ujs

class TestRoom
  constructor: ->
    $('input[name="login"]').click =>
      @login()
  initEvents: ->
    _this = @
    $('li[id^=room-li] > span.btn').click ->
      if $(this).hasClass('active')
        $(this).removeClass('active')
        App.RoomChannel.leave()
        return
      $('li[id^=room-li] > span.btn').removeClass('active')
      $(this).addClass('active')
      data = $(this).data()
      channel = App.RoomChannel.switch data.id, data.name
      _this.bindSubscription channel.subscription
    $('input[name="chat-message"]').on 'keypress', (event) ->
      return unless event.keyCode == 13
      unless App.RoomChannel.current
        alert "请先选择一个频道"
        return
      console.log "saying #{$(this).val()}"
      App.RoomChannel.current.say $(this).val()
      $(this).val('')
  bindSubscription: (subscription) ->
    _received = subscription.received
    subscription.received = (data) =>
      _received data
      @onReceived(data)
  onReceived: (data) ->
    now = new Date()
    switch data.type
      when 'system'
        ele = $("<li class='system'>#{data.message} <small>#{now}</small</li>")
      when 'message'
        ele = $("<li class='message'>#{data.user.nickname} 说：#{data.message} <small>#{now}</small</li>")
      else ele = null
    ele.prependTo('#chat-messages') if ele?
  login: ->
    App.RoomChannel.connect $('input.username').val()
    @initEvents()
    $('.main').removeClass('hide')
    $('.login').addClass('hide')
$ ->
  window.App.testRoom = new TestRoom()
