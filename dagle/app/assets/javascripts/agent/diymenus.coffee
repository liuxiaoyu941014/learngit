# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  setSubMenusMargin = ->
    $('ol.sub-menus').css 'margin-top', '0px'
    $('ol.sub-menus:has("li")').css 'margin-top', '10px'
    return

  olTag = ->
    tag = $('<ol></ol>')
    tag.addClass 'sub-menus'
    tag

  addOrRemoveOl = (li) ->
    if li.find('li').length > 0
      return
    parent = li.parents('ol').first()
    hasOl = li.find('ol').length > 0
    if parent.hasClass('parent-menus')
      if !hasOl
        li.append olTag()
      li.removeData 'subContainers'
    else if parent.hasClass('sub-menus')
      li.find('ol').remove()
    return

  if $('body.agent-diymenus')[0]
    formEle = undefined
    sortMenuEle = undefined
    sortGroup = undefined
    formEle = $('form#form-sort-diymenu')
    formEle.on('ajax:success', (data, status, xhr) ->
      switch status.action
        when 'upload_wx_menu'
          if parseInt(status.msg.code) == 0
            alert("上传成功")
          else
            alert("上传失败，失败原因：" + status.msg.message)
        #when 'sort'
        #  appendFlashMessage 'success', '微信菜单保存成功'
        when 'download_wx_menu'
          if parseInt(status.msg.code) == -1
            alert("下载失败，失败原因：" + status.msg.message)
          else
            alert("下载成功，点击确定开始加载")
            window.location.reload()
            break
      return
    ).on 'ajax:error', (xhr, status, error) ->
      alert("请求失败，请检查网络并重新尝试")
      return
    sortMenuEle = $('ol.sortMenu')
    sortGroup = sortMenuEle.sortable(
      clear: true
      group: 'menu'
      delay: 100
      handle: 'i.fa.fa-arrows'
      onDrop: ($item, container, _super) ->
        addOrRemoveOl $item
        setSubMenusMargin()
        data = sortGroup.sortable('serialize').get()
        jsonString = JSON.stringify(data, null, ' ')
        formEle.find('input[name="state"]').val jsonString
        formEle.submit()
        _super $item, container
        return
      isValidTarget: ($item, container) ->
        # 有3个主菜单,就不能再添加了
        if container.el.hasClass('parent-menus') and container.items.length >= 3
          return false
        hasChild = $item.find('li').length > 0
        if container.el.hasClass('sub-menus')
          # 如果菜单含有子菜单,就不能移动到其他子菜单里面
          if hasChild
            return false
          # 子菜单最多只能 有五个
          if container.items.length >= 5
            return false
        true
    )
    setSubMenusMargin()
  return
