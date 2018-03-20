Vue = require 'vue'
Vue.directive 'focus', inserted: (el) ->
  # 聚焦元素
  el.focus()
