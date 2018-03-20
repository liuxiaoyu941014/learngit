<template>
  <transition name="fade">
    <div class="backdrop" v-if="show" @click.prevent="click"><iframe></iframe><slot></slot></div>
  </transition>
</template>

<script>
export default {
  props: {
    hideOnClick: { type: Boolean, default: true }
  },
  data () {
    return {
      show: true
    }
  },
  methods: {
    click (e) {
      if(this.hideOnClick && e.srcElement.className == 'backdrop') this.show = false
    }
  }
}
</script>

 <style scoped lang="sass?indentedSyntax">
  .backdrop
    z-index: 9999
    position: absolute
    background-color: #000
    width: 100%
    height: 100%
    opacity: 0.75
    iframe
      display: none

  .fade-enter-active, .fade-leave-active
    transition: opacity .5s
  .fade-enter, .fade-leave-active
    opacity: 0
</style>
