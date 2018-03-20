$(document).ready ->
  bodyShow = $('.agent-preorder_conversitions.show')
  if bodyShow.length > 0
    bodyShow.find('.design-sidebar-left #confirm').on 'click', ->
      self = this
      url = $(this).data('url')
      $.ajax
        url: url
        type: 'post'
        data:
          site_confirm: true
        success: (data)->
          if data.status == 'ok'
            if data.factory_confirm == 'true' || data.factory_confirm == true
              scheduleText = '已审核'
            else
              scheduleText = '待工厂方审核'
            bodyShow.find('.design-sidebar-left #schedule').text(scheduleText)
            $.gritter.add({title: '提示', text: "审核完成"})
            $(self).hide()
          else
            $.gritter.add({title: '错误', text: data.message})
        error: ()->
          alert('出错了！审核确认失败')
