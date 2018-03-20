$(document).ready ()->
  bodyMigrate = $('body.admin-forage-data_caches.edit')
  if bodyMigrate.length > 0
    # choose channel for cms_page
    cmsSiteSelect = bodyMigrate.find('.select-cms-site')
    cmsSiteSelect.on 'change', ->
      cmsSiteId = $(this).attr('value')
      if cmsSiteId == ''
        cmsChannelSelect = bodyMigrate.find('.select-cms-channel')
        cmsChannelSelect.empty()
      else
        $.ajax
          url: '/admin/cms/sites/' + cmsSiteId + '/channels'
          type: 'get'
          dataType: 'json'
          error: ->
            updateMessage('发送失败', true)
            cancelTimer()
          success: (resp)->
            cmsChannelSelect = bodyMigrate.find('.select-cms-channel')
            cmsChannelSelect.empty()
            resp.forEach (value) =>
              cmsChannelSelect.append('<option value=' + value.id + '>' + value.title + '</option>')


    # choose site for product
    formatRepo = (resource) ->
      markup = '<p>' + (resource.title || ' ') + '</p>'
      markup

    userFormatSelection = (resource) ->
      '<input type=\'hidden\' id=\'site_id\' name=\'site\' value=' + resource.id + ' />' + (resource.title || ' ')


    $('#choose-site').select2(
      data: [{'id': $('#choose-site').data('id'),'name': $('#choose-site').data('name')}]
      ajax:
        url: $('#choose-site').data('url')
        dataType: 'json',
        delay: 250,
        data: (params) ->
          {
            search: { keywords: params.term }
          }
        processResults: (data, params) ->
          console.log(data.results)
          results: data.results
        cache: true
      escapeMarkup: (markup) ->
        markup
      minimumInputLength: 1
      templateResult: formatRepo
      templateSelection: userFormatSelection
    )
