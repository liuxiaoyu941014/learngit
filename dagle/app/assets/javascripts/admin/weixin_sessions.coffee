# 探码公众号微信登陆

class QrcodeAuth

  constructor: (@loginUrl, @qrcodeUrl, @messageElement, @imageElement) ->

  init: =>
    console.log 'init QrcodeAuth'
    $.getJSON @qrcodeUrl, (data) =>
      console.log('init', @imageElement, data.svg)
      $(@imageElement).attr('src', data.svg)
      @ping(data)

  ping: (response) =>
    $.getJSON response.status_url, (data) =>
      switch data.status
        when 'confirmed'
          $(@messageElement).text('已确认登录，正在获取用户信息...')
          @login(response.code)
        when 'waiting'
          $(@messageElement).text('正在等待扫码...')
          @timer = setTimeout(@ping, 5000, response)
        when 'confirming'
          $(@messageElement).text('等待微信端确认...')
          @timer = setTimeout(@ping, 5000, response)
        when 'expired'
          $(@messageElement).text('二维码过期，正在刷新二维码...')
          @init()

  login: (code) =>
    url = @loginUrl
    $.post url, { code: code }, (data) =>
      if (data.success)
        location.href = '/admin'
      else
        alert '登录失败'

  destroy: =>
    console.log 'destroy QrcodeAuth'
    clearTimeout @timer if @timer
    $(@imageElement).attr('src', 'about:blank')

$(document).ready ->
  body = $('body.admin-sessions.new')
  if body.length > 0
    container = body.find('.weixin-login-container')
    if container.length > 0
      loginUrl = container.data('sessionUrl')
      qrcodeUrl = container.data('verifyUrl')
      imageElement = container.find('img.weixin-login-qrcode')
      messageElement = container.find('.weixin-login-message')
      qa = new QrcodeAuth(loginUrl, qrcodeUrl, messageElement, imageElement)
      body.find('button#weixin-login').on 'click', () =>
        console.log('click')
        if container.hasClass('hide')
          qa.init()
        else
          qa.destroy()
        container.toggleClass('hide')

# 老的微信登陆
# $(document).ready ->
#   body = $('body.admin-sessions.new')
#   if body.length > 0
#     container = body.find('.weixin-login')
#     if container.length > 0
#       console.log(container[0])
#       sessionUrl = container[0].dataset["sessionUrl"]
#       verifyUrl = container[0].dataset["verifyUrl"]
#       qrcodeImgUrl = container[0].dataset["qrcodeImgUrl"]
#       weixin = new Vue
#         el: container[0],
#         data:
#           showModal: false
#           weixinQrcode: ''
#           token: ''
#           timeoutSec: 120
#           showImage: false
#           timer: null
#           stopLogin: false
#         computed:
#           message: ()->
#             if this.timeoutSec <= 0
#               this.message = '登录超时，请关闭重试!'
#             else
#               this.message = '请在'+this.timeoutSec+'内打开微信扫一扫!'
#         watch:
#           showModal: (val)->
#             if val
#               this.loadQrcode()
#             else
#               this.close()
#         methods:
#           loadQrcode: ()->
#             vm = this
#             vm.$http.get(sessionUrl).then((response)->
#               vm.token = response.body.token
#               vm.timeoutSec = response.body.timeout_sec
#               vm.weixinQrcode = qrcodeImgUrl+'?token='+vm.token
#               vm.showImage = true
#               vm.startTimer()
#               vm.checkTokenLogin()
#             ,(response)->

#             )
#           close: ()->
#             vm = this
#             vm.stopLogin = true
#             clearTimeout(vm.timer)
#           checkTokenLogin: ()->
#             vm = this
#             vm.$http.post(verifyUrl, token: vm.token).then((response)->
#               json = response.body
#               console.log(json)
#               if json['status'] == 'ok'
#                 vm.message = '登录成功，正在转到访问页面...'
#                 setTimeout(()->
#                   window.location.href = json["url"]
#                 , 1500);
#               else
#                 if vm.stopLogin == false
#                   window.setTimeout(vm.checkTokenLogin, 3000);
#             ,(response)->

#             )
#           startTimer: ()->
#             vm = this
#             if vm.timeoutSec >= 0
#               vm.timeoutSec--
#               vm.timer = setTimeout(()->
#                 vm.startTimer()
#               , 1000)
#             else
#               vm.stopLogin = true


