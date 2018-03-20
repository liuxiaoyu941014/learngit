$(document).ready ->
  tmp = $(".tracker .share_statistic")
  if tmp.length > 0
    url = tmp.data('url')
    if tmp.hasClass('share_two')
      reUrl = url.substring(0, url.indexOf('shares')+6)
    else
      reUrl = url.substring(0, url.indexOf('two_shares')+10)
    tmp.find('#reUrl').attr('href', reUrl)
    loadData = (selected_page)->
      $.ajax
        type: 'get'
        dataType: 'json'
        url: url
        data:
          page: selected_page || 1
        success: (res)->
          if tmp.hasClass('share_two') || tmp.hasClass('share_three')
            share._data.share_obj = res.data.share_records
          else
            share._data.share_list = res.data.share_records
          share._data.share = res.data.share_records[0]
          share._data.total_pages = res.data.total_pages
          share._data.selected_page = res.data.selected_page
          share._data.showPage = parseInt(res.data.selected_page)
          documentLoadAnimation(true)
        error: ->
          documentLoadAnimation(false, '数据加载失败，请刷新页面')
    loadShareChartData = (date)->
      $.ajax
        type: 'post'
        dataType: 'json'
        url: url+'/chart_data'
        data:
          date: date
        success: (data)->
          share._data.shareChartData[0].values = data.chart_data
          share_chart(share._data.shareChartData)
          documentLoadAnimation(true)
        error: ->
          documentLoadAnimation(false, '数据加载失败，请刷新页面')
    share_chart = (exampleData)->
      nv.addGraph( ()->
        chart = nv.models.discreteBarChart()
          .x((d)-> d.label)
          .y((d)-> d.value)
          .staggerLabels(true)
          .showValues(true)
          .showXAxis(false)
        chart.xAxis
          .axisLabel('日期')
        chart.yAxis
          .axisLabel('分享次数')
          .tickFormat(d3.format('d'))
        d3.select('#chart_pv svg')
            .datum(exampleData)
            .call(chart)
        nv.utils.windowResize(chart.update)
        chart
      )
    bindDatetimepicker = ->
      $('.tracker .datetimepicker-group .datetimepicker').datetimepicker('remove');
      $('.tracker .datetimepicker-group .datetimepicker').datetimepicker({
        autoclose: true
        startView: 3
        minView: 3
      }).on('changeDate', ->
        documentLoadAnimation(false)
        share._data.chartSelectDate = $(this).val()
        loadShareChartData($(this).val())
      )

    share = new Vue
      el: tmp[0]
      data:
        showShareChart: true
        shareChartData: [
          key: 'a1',
          values: [
            {}
          ]
        ]
        share_list: []
        share_obj: {
          root: {}
          records: []
          resource: {}
        }
        chartSelectDate: ""
        total_pages: 1
        selected_page: 1
        showPage: 0
      watch:
        showShareChart: (v)->
          if v
            share_chart(share._data.shareChartData)
          else
            loadData()
      methods:
        redirectTo: (id)->
          if tmp.hasClass('share_two')
            redirectUrl = url + '/' + id + '/three_shares'
          else
            redirectUrl = url + '/' + id + '/two_shares'
          window.location.href = redirectUrl
        loadData: (n)->
          loadData(n)
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
        formatDate: (str) ->
          timeDate = new Date(str)
          year = timeDate.getFullYear()
          month = timeDate.getMonth() + 1
          date = timeDate.getDate()
          hour = timeDate.getHours()
          minute = timeDate.getMinutes()
          second = timeDate.getSeconds()
          return year + '年' + month + '月' + date + '日 ' + hour + '时' + minute + '分' + second + '秒'
        changeDate: ->
          documentLoadAnimation(false)
          loadShareChartData(this.chartSelectDate)
        onMonth: ->
          date = new Date()
          this.chartSelectDate = date.getFullYear()+"-"+(parseInt(date.getMonth())+1)
          this.changeDate()
        # shareCode: (code) ->
        #   return url.substring(0, url.indexOf('tracker')) + "code-" + code
        thinkTime: ->
          date = new Date()
          chartSelectDate = new Date(this.chartSelectDate)
          if (date.getFullYear() == chartSelectDate.getFullYear()) && (date.getMonth() == chartSelectDate.getMonth())
            return "active"
      mounted: ->
        bindDatetimepicker()
        this.onMonth()

    if tmp.hasClass("share_home")
      documentLoadAnimation(false)
      loadShareChartData()
    else
      loadData()
