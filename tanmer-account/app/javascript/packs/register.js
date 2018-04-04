import Vue from 'vue'
import RegisterForm from 'views/register'

document.addEventListener('DOMContentLoaded', () => {
  const box = document.querySelector('registration-box')
  if (box) {
    const props = box.dataset;
    if (process.env.NODE_ENV == 'development') {
      console.log('props is', props)
    }
    new Vue({
      el: box,
      render: h => h(RegisterForm, {props})
    })
  }
})
