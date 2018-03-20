$(document).ready ->
  pages = $('body.agent-products')
  if pages.length > 0
    # tags
    default_site_tags = pages.find('.product-tags').data('site-tags')
    pages.find('.product-tags').tagit({
      fieldName: "product[tag_list][]",
      availableTags: default_site_tags
    })
    pages.find(".most-tag-list span.label").on 'click', ->
      pages.find('.product-tags').tagit 'createTag', $(this).text()
  # index
  bodyIndex = $('body.agent-products.index')
  if bodyIndex.length > 0
    $(".other-attr input[type='checkbox']").each ->
      if $(this).data('val') == 1
        $(this).prop('checked', true)
    catalogDom = bodyIndex.find(".catalog-list[rel='catalog-list']")
    catalog = new Vue
      el: "div[rel='catalog-list']"
      data:
        id: catalogDom[0].dataset["catalogId"]
        showCatalog: false
        catalogs: catalogDom[0].dataset["catalogName"]
        selecteDefault: catalogDom[0].dataset["catalogIds"].split(',')
      methods:
        selected: (catalogs)->
          _this = this
          _this.selecteDefault = []
          catalogs.map (i)->
            _this.selecteDefault.push i.id
          if catalogs.length-1 >= 0
            _this.id = catalogs[catalogs.length-1].id
          else
            _this.id = null
          _this.showCatalog = false
          _this.catalogs = catalogs.map((cata)-> cata.name).join('/')
  # show
  bodyShow = $('body.agent-products.show')
  if bodyShow.length > 0
    # 更改上架标志
    onCheckShelvesStatus = ()->
      bodyShow.find('.process_shelves button').on 'click', ->
        parentsDom = $(this).parents('.process_shelves')
        url = parentsDom.data('url')
        status = $(this).data('status')
        $.ajax
          url: url
          data:
            status: status
          type: 'post'
          success: (data)->
            if data.status == 'ok' && parseInt(status) == 0
              parentsDom.find('button').text('产品上架').removeClass('btn-inverse').addClass('btn-warning').data('status', 1)
            else
              parentsDom.find('button').text('取消上架').removeClass('btn-warning').addClass('btn-inverse').data('status', 0)
            # onCheckShelvesStatus()
          error: (data)->
            alert('错误')
    onCheckShelvesStatus()
    #
    bodyShow.find('ul.checkout_image_list li a').on "click", ->
      imageUrl = $(this).data('url')
      bodyShow.find(".product-main-image[data-id='main-image'] img").attr('src', imageUrl)
      bodyShow.find('ul.checkout_image_list li').removeClass('active')
      $(this).parent().addClass('active')
    setTimeout ->
      bodyShow.find('#editModal .modal-content form').on "ajax:success", (event, request)->
        if request.hasOwnProperty('error')
          $(this).find('.modal-body .alert.alert-danger').removeClass('hide').find('span.title').text(request.error)
          $('#editModal').scrollTop(0)
    # 请求地址
    shareUrl = bodyShow.find(".share[rel='share']").data('url')
    share = new Vue
      el: ".share[rel='share']"
      data:
        showSharModal: false
        url: ''
      methods:
        getSalesDistribution: (product_id)->
          this.showSharModal = true
          self = this
          return if self.url.length > 1
          $.ajax
            url: shareUrl
            type: 'post'
            success: (data)->
              if data.code.length > 1
                self.url = data.share_path
              else
                alert('数据获取失败')
            error: (data)->
              alert('错误')
  # new
  bodyNew = $('body.agent-products.new')
  if bodyNew.length > 0
    # 检测名称是否填写
    bodyNew.find('input#product_name').val('')
    $("#basicInformation a[href='#configurationInformation']").on　'show.bs.tab', ->
      productNameDom = $(this).parents('#basicInformation').find('input#product_name')
      if productNameDom.val() == "" || productNameDom == null
        $.gritter.add({title: '提示', text: "商品基本信息：产品名称必须填写！"})
        productNameDom.css('border','1px solid red')
        productNameDom.on 'focus', ->
          productNameDom.css('border','1px solid #ccd0d4')
        return false

    bodyNew.find('.weight-input-group .input-group-btn ul.dropdown-menu li a').off().on 'click', ->
      selectedVal = $(this).data('val')
      selectedText = $(this).text()
      $(this).parents('.weight-input-group').find('.input-group-btn .dropdown-toggle small').text(selectedText)
      $(this).parents('.weight-input-group').find('input.hidden-input').val(selectedVal)
    container = bodyNew.find('.catalog-list')
    catalog = new Vue
      el: "div[rel='catalog-list']"
      data:
        id: container[0].dataset["catalogId"]
        showCatalog: false
        catalogs: container[0].dataset["catalogName"]
        selecteDefault: []
      methods:
        selected: (catalogs)->
          _this = this
          _this.selecteDefault = []
          catalogs.map (i)->
            _this.selecteDefault.push i.id
          if catalogs.length-1 >= 0
            _this.id = catalogs[catalogs.length-1].id
          else
            _this.id = null
          _this.showCatalog = false
          _this.catalogs = catalogs.map((cata)-> cata.name).join('/')
    additional = new Vue
      el: "div[rel='additional-attributes']"
      data:
        lists: [
          {key: '', value: '', name: '1'}
          {key: '', value: '', name: '2'}
        ]
        count: 3
      methods:
        addInputList: ->
          this.lists.push({key: '', value: '', name: this.count})
          this.count++
        removeInputList: (index)->
          this.lists.splice(index, 1)

    adddata= new Vue
      el: "div[rel='additional-data']"
      data:
        lists: [
          {key: '', value: '', name: '1'}
          {key: '', value: '', name: '2'}
        ]
        count: 3
      methods:
        addInputList1: ->
          this.lists.push({key: '', value: '', name: this.count})
          this.count++
        removeInputList1: (index)->
          this.lists.splice(index, 1)

    addstock= new Vue
      el: "div[rel='add_stock']"
      data:
        lists: [
          {key: '', value: '', name: '1'}
          {key: '', value: '', name: '2'}
        ]
        count: 3
      methods:
        addInputList3: ->
          this.lists.push({key: '', value: '', name: this.count})
          this.count++
        removeInputList3: (index)->
          this.lists.splice(index, 1)


    bodyNew.find('.change-step').on 'click', ->
      $(window).scrollTop(0)
      change_step_class = $(this).attr("href").replace("#", "")
      bodyNew.find('.checkout-header .step').removeClass('active')
      bodyNew.find("."+change_step_class).addClass('active')
    bodyNew.find('form#new_product').on 'ajax:error', (event,request)->
      $.gritter.add({title: '提示', text: '商品发布失败!'})
    bodyNew.find('form#new_product').on 'ajax:success', (event,request)->
      $(window).scrollTop(0)
      bodyNew.find('.checkout-header .step').removeClass('active')
      bodyNew.find("[role='tabpanel']").removeClass('active in fade')
      if request.errors
        $.gritter.add({title: '提示', text: request.errors})
        bodyNew.find('.basicInformation.step').addClass('active')
        bodyNew.find('#basicInformation').addClass('active')
      else
        bodyNew.find('#last .new-product').attr("href", request.url)
        bodyNew.find('.last.step').addClass('active')
        bodyNew.find('#last').addClass('active in')

  # edit
  bodyEdit
  bodyEdit = $('body.agent-products.edit')
  if bodyEdit.length > 0
    # 商品单位切换显示
    setTimeout ->
      bodyEdit.find('.weight-input-group .input-group-btn ul.dropdown-menu li a').on 'click', ->
        selectedVal = $(this).data('val')
        selectedText = $(this).text()
        $(this).parents('.weight-input-group').find('.input-group-btn .dropdown-toggle small').text(selectedText)
        $(this).parents('.weight-input-group').find('input.hidden-input').val(selectedVal)
    , 500
    # 图片- Vue
    imageSelectDom = bodyEdit.find(".form-group[rel='image-select']")
    imageSelect = new Vue
      el: imageSelectDom[0]
    # 分类 - Vue
    container = bodyEdit.find('.catalog-list')
    catalogListDom = new Vue
      el: container[0]
      data:
        id: container[0].dataset["catalogId"]
        showCatalog: false
        catalogs: container[0].dataset["catalogName"]
        selecteDefault: container[0].dataset["catalogIds"].split(',')
      methods:
        selected: (catalogs)->
          _this = this
          _this.selecteDefault = []
          catalogs.map (i)->
            _this.selecteDefault.push i.id
          if catalogs.length-1 >= 0
            _this.id = catalogs[catalogs.length-1].id
          else
            _this.id = null
          _this.showCatalog = false
          _this.catalogs = catalogs.map((cata)-> cata.name).join('/')
    # 附加属性添加
    attrListDom = bodyEdit.find("div[rel='attr_list_vue']")
    attrList = new Vue
      el: attrListDom[0]
      data:
        defaultvalues: {}
        defaultkeys: {}
        lists: []
        count: 1
      methods:
        addInputList: ->
          this.count++
          this.lists.push({key: '', value: '', name: this.count})
        removeInputList: (index)->
          this.lists.splice(index, 1)
    defaultkeys = bodyEdit.find("div[rel='attr_list_vue']").data('keys')
    defaultvalues = bodyEdit.find("div[rel='attr_list_vue']").data('values')
    attrList.lists = []
    max = 0
    for name, v of defaultkeys
      if parseInt(name) > 0
        max = parseInt(name) if max < parseInt(name)
        attrList.lists.push {key: v, name: parseInt(name), value: defaultvalues[name]}
        attrList.count = max+1
    attrList.lists.push {key: ' ', name: attrList.count, value: ' '}

 # 附加日期添加
    attrDateDom = bodyEdit.find("div[rel='attr_date']")
    attrDate = new Vue
      el: attrDateDom[0]
      data:
        defaultvalues: {}
        defaultkeys: {}
        lists: []
        count: 1
      methods:
        addInputList2: ->
          this.count++
          this.lists.push({key: '', value: '', name: this.count})
        removeInputList2: (index)->
          this.lists.splice(index, 1)
    defaultkeys = bodyEdit.find("div[rel='attr_date']").data('keys')
    defaultvalues = bodyEdit.find("div[rel='attr_date']").data('values')
    attrDate.lists = []
    max = 0
    for name, v of defaultkeys
      if parseInt(name) > 0
        max = parseInt(name) if max < parseInt(name)
        attrDate.lists.push {key: v, name: parseInt(name), value: defaultvalues[name]}
        attrDate.count = max+1
     attrDate.lists.push {key: ' ', name: attrDate.count, value: ' '}

#附加库存选择
    attrStockDom = bodyEdit.find("div[rel='attr-stock']")
    attrStock = new Vue
      el: attrStockDom[0]
      data:
        defaultvalues: {}
        defaultkeys: {}
        lists: []
        count: 1
      methods:
        addInputList3: ->
          this.count++
          this.lists.push({key: '', value: '', name: this.count})
        removeInputList3: (index)->
          this.lists.splice(index, 1)
    defaultkeys = bodyEdit.find("div[rel='attr-stock']").data('keys')
    defaultvalues = bodyEdit.find("div[rel='attr-stock']").data('values')
    attrStock.lists = []
    max = 0
    for name, v of defaultkeys
      if parseInt(name) > 0
        max = parseInt(name) if max < parseInt(name)
        attrStock.lists.push {key: v, name: parseInt(name), value: defaultvalues[name]}
        attrStock.count = max+1
     attrStock.lists.push {key: ' ', name: attrStock.count, value: ' '}
