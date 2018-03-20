$(document).ready ->
  $.fn.modal.Constructor.prototype.enforceFocus = ()->
  domModal = $('#newPreorderConversitionModal')
  domAddMemberButton = $('#addMemberButton')
  domAddMemberCloseButton = $('.close-add-member-modal')
  domAddMemberModal = $('#addMember')
  domMemberSelect = $(".select2.select-member")
  domModal.find('.error-text').text('').hide()
  newOrdersDesign = new Vue
    el: domModal.find('image-select')[0]
  domModal.find('form#new_preorder_conversition').on 'ajax:success', (event, request) ->
    if request.status == 'ok'
      domModal.modal('hide')
      window.location = request.url
      console.log(request.url);
    else
      domModal.find('.error-text').show().text('创建失败！：  '+request.message)
  domModal.find('form#new_preorder_conversition').on 'ajax:error', (event, request) ->
    domModal.find('.error-text').show().text('创建失败! ')
  $('#newPreorderConversitionModal').on 'hidden.bs.modal', (e) ->
    domModal.find('.error-text').text('').hide()
  # 快速添加member
  # 关闭modal
  domAddMemberButton.on 'click', ->
    domAddMemberModal.show()
  # 打开添加客户的modal
  domAddMemberCloseButton.on 'click', ->
    domAddMemberModal.hide()
  # // ajax提交创建member
  domAddMemberModal.find('form#new_member').on 'ajax:success', (event, request) ->
    if request.status == 'ok'
      console.log(request.member)
      text = '暂无'
      if request.member.mobile_phone.length > 0
        text = request.member.mobile_phone
      domMemberSelect.select2({
        data: [
          {
            id: request.member.id,
            text: request.member.name + '(' + text + ')'
          }
        ]
      })
      domMemberSelect.val(request.member.id).trigger("change")
      domAddMemberModal.hide()
    else
      console.log('error')
      domAddMemberModal.find('.error-text').show().text('创建失败！：  '+request.message)
  domModal.find('form#new_member').on 'ajax:error', (event, request) ->
    domModal.find('.error-text').show().text('网络错误! ')