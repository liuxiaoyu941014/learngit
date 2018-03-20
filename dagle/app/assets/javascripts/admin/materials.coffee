$(document).ready ()->
  pages = $('body.admin-materials')
  pages_index = $('body.admin-materials.index')
  if pages.length > 0
    container = pages.find(".catalog-list")
    if container.length > 0
      catalog = new Vue
        el: container[0]
        data:
          id: container[0].dataset["catalogId"]
          showCatalog: false
          catalogs: container[0].dataset["catalogName"]
        methods:
          selected: (catalogs)->
            _this = this
            _this.id = catalogs[catalogs.length-1].id
            _this.showCatalog = false
            _this.catalogs = catalogs.map((cata)-> cata.name).join('/')
      image_container = pages.find('image-select')
      image = new Vue
        el: image_container[0]
  if pages_index.length > 0
    $('tr.warehouse-list').on 'click', ->
      $('tr.warehouse-list').popover('destroy')
      stocks = $(this).data('stock')
      $(this).popover({
        content: ->
          str = ""
          for stock in stocks
            str += "<p>" + stock + "</p>"
          str
        ,
        title: '仓库库存',
        placement: "bottom",
        html: true
      })
      $(this).popover('show')
