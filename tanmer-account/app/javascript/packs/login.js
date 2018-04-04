import Vue from 'vue'
import LoginForm from 'views/login'

document.addEventListener('DOMContentLoaded', () => {
  const box = document.querySelector('login-box')
  if (box) {
    const props = box.dataset;
    if (process.env.NODE_ENV == 'development') {
      console.log('props is', props)
    }
    new Vue({
      el: box,
      render: h => h(LoginForm, {props})
    })
  }
})
