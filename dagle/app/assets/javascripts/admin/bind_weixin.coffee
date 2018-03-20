$(document).ready ->
  body = $('body.admin-users.show')
  if body.length > 0
    container = body.find('.bind-user')
    if container.length > 0
      console.log(container[0])
      bindUrl = container[0].dataset["bindUrl"]
      verifyUrl = container[0].dataset["verifyUrl"]
      qrcodeImgUrl = container[0].dataset["qrcodeImgUrl"]
      weixin = new Vue
        el: container[0],
        data:
          showModal: false
          weixinQrcode: ''
          token: ''
          timeoutSec: 120
          showImage: false
          timer: null
          stopLogin: false
        computed:
          message: ()->
            if this.timeoutSec <= 0
              this.message = '绑定超时，请关闭重试!'
            else
              this.message = '请在'+this.timeoutSec+'内打开微信扫一扫!'
        watch:
          showModal: (val)->
            if val
              this.loadQrcode()
            else
              this.close()
        methods:
          loadQrcode: ()->
            vm = this
            vm.$http.get(bindUrl).then((response)->
              vm.token = response.body.token
              vm.timeoutSec = response.body.timeout_sec
              vm.weixinQrcode = qrcodeImgUrl+'?token='+vm.token
              vm.showImage = true
              vm.startTimer()
              vm.checkTokenLogin()
            ,(response)->

            )
          close: ()->
            vm = this
            vm.stopLogin = true
            clearTimeout(vm.timer)
          checkTokenLogin: ()->
            vm = this
            vm.$http.post(verifyUrl, token: vm.token).then((response)->
              json = response.body
              console.log(json)
              if json['status'] == 'success'
                vm.message = '页面绑定成功！'
                setTimeout(()-> 
                   location.reload()
                , 1500);
              else if json["status"] == 'used'
                vm.message = '该账户已经绑定！'
                vm.showModal = false
              else
                if vm.stopLogin == false
                  window.setTimeout(vm.checkTokenLogin, 3000);
            ,(response)->

            )
          startTimer: ()->
            vm = this
            if vm.timeoutSec >= 0
              vm.timeoutSec--
              vm.timer = setTimeout(()->
                vm.startTimer()
              , 1000)
            else
              vm.stopLogin = true

            