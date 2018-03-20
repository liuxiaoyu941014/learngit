$(document).ready ()->
  pages = $('body.admin-orders')
  if pages.length > 0
    container = pages.find(".order-form")
    if container.length > 0
      image_container = container.find('image-select')
      image = new Vue
        el: image_container[0]
  bodyShow = $('body.admin-orders.show')
  if bodyShow.length > 0
    refund = $('#refundModal')
    refund.each ->
      $(this).on 'ajax:success', (event, request) ->
        if request.status == 'ok'
          bodyShow.find('.refund-button').replaceWith("<span class='btn btn-xs btn-warning'>已经提交退款申请</span>")
          refund.modal('hide')
          $.gritter.add({title: '提示', text: request.message})
        else
          $.gritter.add({title: '错误', text: request.message})
      $(this).on 'ajax:error', (event, request) ->
        $.gritter.add({title: '错误', text: '网络错误'})
  bodyRefund = $('body.admin-orders.refunds')
  if bodyRefund.length > 0
    refund = $('.refund-link')
    refund.each ->
      $(this).on 'ajax:success', (event, request) ->
        if request.status == 'ok'
          $(this).text("退款中")
          $.gritter.add({title: '提示', text: request.message})
        else
          $.gritter.add({title: '错误', text: request.message})
      $(this).on 'ajax:error', (event, request) ->
        $.gritter.add({title: '错误', text: '网络错误'})
