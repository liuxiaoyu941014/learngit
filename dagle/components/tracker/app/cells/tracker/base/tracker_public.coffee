$(document).ready ->
  tmp = $('.tracker')
  if tmp.length > 0
    window.documentLoadAnimation = (control, texts)->
      tests = texts or "数据加载中"
      if control
        tmp.find('.load_dom').remove()
      else
        if tmp.find('.load_dom').length > 0
          tmp.find('.load_dom span').addClass('text-danger').text(texts)
        else
          tmp.append("<div class='load_dom h4'><i class='fa fa-spinner'></i><span>"+tests+"</span></div>")
    documentLoadAnimation()
