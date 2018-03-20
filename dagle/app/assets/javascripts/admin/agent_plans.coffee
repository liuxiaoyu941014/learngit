$(document).ready ()->
  pages = $('body.admin-agent_plans')
  if pages.length > 0
    attrListDom = pages.find("div[rel='features_list_vue']")
    featureList = new Vue
      el: attrListDom[0]
      data:
        list: []
      methods:
        addInputList: ->
          this.list.push({key: ''})
        removeInputList: (index)->
          this.list.splice(index, 1)
    featureList.list = []
    initList = pages.find("div[rel='features_list_vue']").data('values') || []
    for name,v of initList
      featureList.list.push {key: v}