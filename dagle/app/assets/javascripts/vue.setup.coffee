$ ->
  store = new Vuex.Store
    state:
      loading: false
  vueSelector = '[rel="vue"]'
  $(vueSelector).each (i, el)->
    new Vue
      el: el
      store: store
