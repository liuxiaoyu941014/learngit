$(document).ready ()->
  pages = $('body.admin-catalogs.index')
  if pages.length > 0
    container = pages.find('catalog-list')
    new Vue
      el: container[0]
