$(document).ready ()->
  pages = $('body.admin-articles')
  if pages.length > 0
    image_container = pages.find('image-select')
    if image_container.length > 0
      image = new Vue
        el: image_container[0]

    # 时间选择控件绑定
    $('.date_form_datetime').datetimepicker
      format: 'yyyy-mm-dd'
      autoclose: true
      startView: 4
      minView: 2

    recommend = $('.recommend')
    recommend.each ->
      $(this).on 'ajax:success', (event, request) ->
        if request.status == 'ok'
          if request.recommend
            $(this).text("取消平台推荐")
            $(this).attr("class", "btn btn-xs btn-warning")
          else
            $(this).text("设为平台推荐")
            $(this).attr("class", "btn btn-xs btn-success")
          $.gritter.add({title: '提示', text: request.message})
        else
          $.gritter.add({title: '错误', text: request.message})
      $(this).on 'ajax:error', (event, request) ->
        $.gritter.add({title: '错误', text: '网络错误'})
