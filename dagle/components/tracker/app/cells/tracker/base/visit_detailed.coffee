$(document).ready ->
  tmp = $ ".tracker .visit_detailed"
  if tmp.length > 0
    load_url = tmp.data('url')
    loadDetailed = (selected_page)->
      $(document).scrollTop(0)
      console.log(selected_page)
      $.ajax
        type: 'get'
        url: load_url
        dataType: 'json'
        data:
          page: selected_page || 1
        success: (data)->
          app._data.visits = data.visits
          app._data.total_pages = data.total_pages
          app._data.selected_page = data.selected_page
          app._data.showPage = parseInt(data.selected_page)
          documentLoadAnimation(true)
        error: ->
          documentLoadAnimation(false, '数据加载失败，请刷新页面')
    app = new Vue
      el: tmp[0]
      data:
        visits: []
        total_pages: 1
        selected_page: 1
        showPage: 0
      methods:
        loadDetailed: (n)->
          loadDetailed(n)
        onPreviousPageGroup: ()->
          if (this.showPage-5) > 0
            this.showPage = this.showPage-5
          else
            this.showPage = 0
        onNextPageGroup: ()->
          if this.total_pages > 5
            if (this.showPage + 10) <= this.total_pages
              this.showPage = this.showPage + 5
            else
              this.showPage = this.total_pages - 5
    loadDetailed()
