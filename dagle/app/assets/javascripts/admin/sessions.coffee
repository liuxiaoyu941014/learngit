# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  body = $('body.admin-sessions.new')
  if body.length > 0
    setinterval_1 = null
    reg = /^1(3|4|5|7|8)\d{9}$/
    body.find('#mobile_login_modal').on 'hidden.bs.modal', ->
      $(this).find('.modal-body .title_error').text('')
      $(this).find('.modal-body .get_code')
        .text('获取验证码')
        .removeAttr('disabled')
        .attr('pop', false)
      if setinterval_1
        clearInterval setinterval_1
    #　验证码请求
    body.find('#mobile_login_modal .modal-body .get_code').on 'click', ->
      this_dom = $(this)
      mobile = this_dom.parents('.modal-body').find("input[name='user[mobile]']").val()
      if this_dom.attr('pop') != 'true'
        if reg.test(mobile)
          this_dom.attr('pop', true)
          this_dom.parents('.form-group').next('.title_error').text('')
          url = this_dom.data('url')
          time_second = 60
          this_dom.attr('disabled','disabled')
          setinterval_1 = setInterval ->
            if time_second > 0
              this_dom.text(--time_second + ' S')
            else
              this_dom.text('获取验证码')
              clearInterval setinterval_1
              this_dom.removeAttr('disabled')
              this_dom.attr('pop', false)
          ,1000
          $.ajax
            url: url
            type: 'post'
            data:
              mobile: mobile
            error: ->
              return_mess(setinterval_1, '发送失败！')
            success: (data)->
              if data.status == 'error'
                return_mess(setinterval_1, data.message)
              else
                return_mess(setinterval_1, data.message, true)
        else
          return_mess(setinterval_1, '发送失败！请检查手机号码是否正确！')
    # 发送请求
    body.find('#mobile_login_modal .modal-body form').on 'ajax:error', (event,request)->
      return_mess(setinterval_1, '发送失败！请检查网络')
    body.find('#mobile_login_modal .modal-body form').on 'ajax:success', (event,request)->
      if request.hasOwnProperty('error')
        return_mess(setinterval_1, request.error)
      else
        # window.location.href = body.find('#mobile_login_modal .modal-body #click_login').data('href')
        window.location.href = request.url
    body.find('#email_login_modal .modal-body form').on 'ajax:error', (event,request)->
      error_dom = body.find('#email_login_modal .modal-body .title_error')
      error_dom.addClass('text-danger').text('发送失败！请检查网络')
    body.find('#email_login_modal .modal-body form').on 'ajax:success', (event,request)->
      if request.hasOwnProperty('error')
        error_dom = body.find('#email_login_modal .modal-body .title_error')
        error_dom.addClass('text-danger').text(request.error)    
      else
        # window.location.href = body.find('#mobile_login_modal .modal-body #click_login').data('href')
        window.location.href = request.url
  # 清除计时，返回消息
  return_mess = (setinterval_1, text, status)->
    color = 'text-danger'
    if status
      color = 'text-success'
    else
      get_code_dom = body.find('#mobile_login_modal .modal-body .get_code')
      get_code_dom.text('获取验证码')
      get_code_dom.attr('pop', false)
      clearInterval setinterval_1
    error_dom = body.find('#mobile_login_modal .modal-body .title_error')
    error_dom.removeClass('text-success').removeClass('text-danger').addClass(color).text(text)

