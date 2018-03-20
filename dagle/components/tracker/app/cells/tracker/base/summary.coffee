$(document).ready ->
  tmp = $ ".tracker .summary"
  if tmp.length > 0
    load_url = tmp.data('url')

    loadSummary = ->
      $.get load_url, (res)->
        visits_count = res.data.visits_count
        app1._data.total_browse  = visits_count.total_browse
        app1._data.today_browse  = visits_count.today_browse
        app1._data.session_count = visits_count.session_count
        app1._data.today_session = visits_count.today_session
        app1._data.share_count   = visits_count.share_count
        app1._data.today_share   = visits_count.today_share
        linesChart res.data.chart_data
        documentLoadAnimation(true)
      ,'json'
      .error ->
        documentLoadAnimation(false, '数据加载失败，请刷新页面')

    app1 = new Vue
      el: tmp[0]
      data:
        total_browse: '--'
        today_browse: '--'
        session_count: '--'
        today_session: '--'
        share_count: '--'
        today_share: '--'

    linesChart = (data)->
      nv.addGraph ->
        chart = nv.models.lineChart().useInteractiveGuideline(true)
        chart.xAxis
          .axisLabel('日期 (ms)')
          .tickFormat (d)->
            d3.time.format('%Y/%m/%d')(new Date(parseInt(d+'000')))
        chart.yAxis
          .axisLabel('访问量 (v)')
          .tickFormat(d3.format('d'))
        myData = encChartLinesDate data
        d3.select('.tracker .summary .chart_line svg')
          .datum(myData)
          .transition().duration(500)
          .call(chart)
        nv.utils.windowResize ->
          chart.update()
        chart

    encChartLinesDate = (data)->
      return [
        {
          values: data[0]
          key: 'IP量',
          color: '#ff7f0e',
          area: true
        },
        {
          values: data[1]
          key: '访客数',
          color: '#7777ff',
          area: true
        }
      ]

    loadSummary()
