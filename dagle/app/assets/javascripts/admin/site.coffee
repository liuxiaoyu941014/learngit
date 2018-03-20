$(document).ready ()->
  pages = $('body.admin-sites')
  if pages.length > 0
    container = pages.find('.catalog-list')
    if container.length > 0
      catalog = new Vue
        el: container[0]
        data:
          id: container[0].dataset["catalogId"]
          showCatalog: false
          catalogs: container[0].dataset["catalogName"]
        methods:
          selected: (catalogs)->
            this.catalog =  catalogs[catalogs.length-1]
            this.id = this.catalog.id
            this.showCatalog = false
            this.catalogs = catalogs.map((cata)-> cata.name).join('/')

    image_container = pages.find('image-select')
    image = new Vue
      el: image_container[0]
