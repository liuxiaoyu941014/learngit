formatRepo = (resource) ->
  markup = '<p>' + (resource.nickname || resource.code || ' ') + '</p>'
  markup
userFormatSelection = (resource) ->
  '<input type=\'hidden\' id=\'user_id\' name=\'username\' value=' + resource.id + ' />' + (resource.nickname || resource.code || ' ')

$(document).ready ->
  $('input[name="daterange"], .daterange').daterangepicker({ 
    format: 'YYYY-MM-DD',
    locale: {
      cancelLabel: '取消',
      applyLabel: '确认',
      fromLabel: '从',
      toLabel: '到',
      daysOfWeek: ['日', '一', '二', '三', '四', '五', '六'],
      monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月', ]
    }
  })
  $('#dropdown').select2(
    data: [{'id': $('#dropdown').data('id'),'nickname': $('#dropdown').data('name')}]
    ajax:
      url: $("#dropdown").data('url')
      dataType: 'json'
      delay: 250
      data: (params) ->
        {
          q: params.term
          page: params.page
        }
      processResults: (data, params) ->
        params.page = params.page or 1
        {
          results: data.results
          pagination: more: params.page * 30 < data.total_count
        }
      cache: true
    escapeMarkup: (markup) ->
      markup
    minimumInputLength: 1
    templateResult: formatRepo
    templateSelection: userFormatSelection)#.select2()
      # data: [{'id': $('#dropdown').data('id'),'text': $('#dropdown').data('name')}])
