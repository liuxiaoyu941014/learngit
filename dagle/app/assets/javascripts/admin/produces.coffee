$(document).ready ->
  pageIndex = $('body.admin-produces.index')
  if pageIndex.length > 0
    dataPath = null
    # modal 样式重置
    pageIndex.find('.modal.create_task').on 'show.bs.modal', ->
      $(this).find('.continue .list-group a.list-group-item').removeClass('task-active')
        .find('i.fa').removeClass('fa-check-circle-o').addClass('fa-circle-o')
    # open modal
    pageIndex.find("td a[data-target='.create_task']").on 'click', ->
      $(this).parents('tbody').find('a').removeClass('selected')
      $(this).addClass('selected')
      $('.modal.create_task .modal-body .well .h6 span').text($(this).data('code'))
      dataPath = $(this).data('path')
    # 选中数据
    pageIndex.find('.modal.create_task .modal-body .continue a.list-group-item').on 'click', ->
      pageIndex.find(".modal.create_task .continue .error-messages").text('')
      if $(this).hasClass('task-active')
        $(this).removeClass('task-active')
        $(this).find('i.fa').removeClass('fa-check-circle-o').addClass('fa-circle-o')
      else
        $(this).addClass('task-active')
        $(this).find('i.fa').removeClass('fa-circle-o').addClass('fa-check-circle-o')
    # task 数据提交/创建
    pageIndex.find(".modal.create_task .modal-footer .btn-create-task").on 'click', ->
      taskTypeIds = []
      pageIndex.find('.modal.create_task .modal-body .continue a.list-group-item').each ->
        if $(this).hasClass('task-active')
          taskTypeIds.push $(this).data('id')
      if taskTypeIds.length > 0
        $.ajax
          url: dataPath
          type: 'post'
          data:
            taskTypeIds: taskTypeIds
          error: (data)->
            pageIndex.find(".modal.create_task .continue .error-messages").text(data.responseText)
          success: (data)->
            pageIndex.find("tbody tr td a.selected").parents('tr').find('td a.hide').removeClass('hide')
            pageIndex.find("tbody tr td a.selected").parents('td').replaceWith '
              <td>
                <div class="progress">
                  <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                    0%
                  </div>
                </div>
              </td>
            '
            $('.modal.create_task').modal('hide')
      else
        pageIndex.find(".modal.create_task .continue .error-messages").text('错误：至少选择一个任务！')
  pageShow = $('body.admin-produces.show')
  if pageShow.length > 0
    # 修改分配任务负责人
    pageShow.find("form input[type='submit'].btn").removeAttr('disabled')
    pageShow.find('.produce-info ul.edit-member li a').on 'click', ->
      dom = $(this)
      $.ajax
        url: dom.data('url')
        type: 'PATCH'
        data:
          produce:
            assignee_id: dom.data('id')
        success: (data)->
          dom.parents('.btn-group').find('.task-user').text(dom.text())
        error: (data)->
          alert(data.error)

    # 修改分配状态
    classStyleStatus = {processing: 'warning' ,cancelled: 'default', completed: 'success'}
    pageShow.find('.tasks_list ul.edit-status li a').on 'click', ->
      dom = $(this)
      $.ajax
        url: dom.data('url')
        type: 'PATCH'
        success: (data)->
          dom.parents('span.pull-right').find('button.dropdown-toggle').attr('class', 'btn btn-xs dropdown-toggle btn-'+classStyleStatus[data.status]).find('b').text(dom.text())
        error: (data)->
          console.log data.error
