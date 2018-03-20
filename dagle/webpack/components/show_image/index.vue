<template>
  <div class="full-screen" v-if="showSccren">
    <div class="bac-black" @click="colse"></div>
    <div class="img-border">
      <img :src="src" :alt="alt" :title="title">
    </div>
    <div class="close-btn" @click="colse">
      关闭
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      showSccren: {type: Boolean, require: true, default: false},
      src: {type: String, require: true},
      title: {tyep: String},
      alt: {type: String, default: "图片加载失败"}
    },
    watch: {
      showSccren (v) {
        if (v) {
          $('body').css("overflow", 'hidden')
        }else {
          $('body').css("overflow", 'auto');
        }
      }
    },
    data () {
      return {}
    },
    methods: {
      colse () {
        this.$parent.showFullImage = false
      }
    },
    mounted () {
      console.log(this.showSccren)
    }
  }
</script>

<style scoped>
  .overflow-body{
    overflow: hidden;
  }
  .full-screen{
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0px;
    left: 0px;
    z-index: 10000;
  }
  .full-screen .bac-black{
    position: absolute;
    background: rgba(0,0,0,0.8);
    width: 100%;
    height: 100%;
    top: 0px;
    left: 0px;
    z-index: 10001;
  }
  .full-screen img{
    height: 85%;
    text-align: center;
    position: absolute;
    margin: auto;
    top: 0px;
    right: 0px;
    left: 0px;
    bottom:0px;
    border: 1px solid #fff;
    z-index: 10002;
    padding: 2px;
    font-size: 25px;
    color: #E33737;
  }
  .full-screen .no-file{
    color: #fff
  }
  .full-screen .close-btn{
    background: #000;
    position: absolute;
    right: 10px;
    top: 10px;
    color: red;
    z-index: 10003;
    cursor: pointer;
  }
</style>
