$(document).ready ->
  forms = $('form#frontend-order-new')
  if forms.length > 0
    # 附加属性添加
    attrListDom = forms.find("div[rel='signup_members_vue']")
    maximumForOneOrder = attrListDom.data("maximum-for-one-order")
    attrList = new Vue
      el: attrListDom[0]
      data:
        defaultvalues: {}
        defaultkeys: {}
        members: [{key: (new Date()).getTime()}]
      methods:
        addMembers: ->
          if (this.members.length >= maximumForOneOrder)
            alert('一个订单最多定' + maximumForOneOrder + '个!')
          else
            console.log('add members')
            this.members.push({key: (new Date()).getTime()})
        removeMembers: (index)->
          if (this.members.length > 1)
            this.members.splice(index, 1)
          else
            alert('至少填写一个名额')
    # defaultkeys = bodyEdit.find("div[rel='attr_list_vue']").data('keys')
    # defaultvalues = bodyEdit.find("div[rel='attr_list_vue']").data('values')
    # attrList.lists = []
    # max = 0
    # for name, v of defaultkeys
    #   if parseInt(name) > 0
    #     max = parseInt(name) if max < parseInt(name)
    #     attrList.lists.push {key: v, name: parseInt(name), value: defaultvalues[name]}
    #     attrList.count = max+1
    # attrList.lists.push {key: ' ', name: attrList.count, value: ' '}