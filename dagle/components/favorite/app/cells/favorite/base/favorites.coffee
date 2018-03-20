$(document).ready ->

  processFavorite = () ->
    buttonBlock = $(this)
    url = buttonBlock.data('url')
    buttonBlock.attr 'uuid', "#{new Date().getTime()}-#{Math.random()}"

    postFavorite = ->
      $.post url
        .success (data)->
          app._data.isFavorite = data
        .error (error)->
          alert error
      

    deleteFavorite = ->
      $.ajax url, type: 'delete'
        .success (data)->
          app._data.isFavorite = data
        .error (error)->
          alert error

    loadFavorite = ->
      $.get url
        .success (data)->
          app._data.isFavorite = data
        .error (error)->
          alert error

    app = new Vue
      el: "[rel='favorite-button'][uuid='#{buttonBlock.attr('uuid')}']"
      data: 
        isFavorite: false
      methods:
        postFavorite: postFavorite 
        deleteFavorite: deleteFavorite

    loadFavorite()

  $('[rel="favorite-button"]').each processFavorite
