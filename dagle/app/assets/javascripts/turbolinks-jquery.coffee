jQuery.fn.ready = (fn)->
  $(this).on 'turbolinks:load', fn
