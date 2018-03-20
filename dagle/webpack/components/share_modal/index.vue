<template>
  <modal :title="title" :show.sync="showModal" @cancel="close" :large="false" >
    <div slot="title" style="display: inline-block;">
      <div class="small">
        分享{{title}}
      </div>
    </div>
    <div class="modal-body">
      <div class="body-title">
        <span class="text-info" v-if="url.length > 1">
          <i class="fa fa-share-alt-square"></i>分享链接已经生成
        </span>
        <span class="text-warning" v-else>
          <i class="fa fa-spinner"></i>分享链接生成中......
        </span>
      </div>
      <div class="row">
        <div class="col-md-10 col-xs-9 link">
          <input id="shareUrl" type="text" name="" :value="url" class="form-control" >
        </div>
        <div class="col-md-2 col-xs-3">
          <button type="button" class="btn red btn-info pull-right copy" data-clipboard-target="#shareUrl">复制链接</button>
        </div>
        <div class="col-md-12 col-xs-12 text-center">
          <hr/>
          <div class="rqrcode" v-if="qrImageUrl.length > 1">
            <img :src="qrImageUrl" alt="二维码加载失败" title="二维码: 链接扫一扫" >
          </div>
          <div id="rqrcode" class="rqrcode" v-else></div>
        </div>
      </div>
    </div>
    <div slot="footer">
    </div>
  </modal>
</template>
<script>
import Clipboard from 'clipboard'
export default {
  props: {
    title: {type: String, require: true},
    url: {type: String, require: true},
    qrImageUrl: {type: String, default: ''},
    showModal: {type: Boolean, default: false}
  },
  data () {
    return {
    }
  },
  watch: {
    url (v) {
      if (this.url.length > 1) {
        this.qrcode()
      }
    }
  },
  methods: {
    close () {
      this.$emit('close')
    },
    qrcode () {
      if (this.qrImageUrl.length < 1) {
        $("#rqrcode").qrcode({
          text: this.url,
          width: 150,
          height: 150
        })
      }
    }
  },
  mounted () {
    this.$nextTick(function () {
      // Clipboard js
      new Clipboard('.copy')
      // require qrcode js
      require ('../share_modal/jquery.qrcode.min.js')
    })
  }
}
</script>

<style lang="css" scoped>
  i.fa-spinner{
    animation: rotation 1.5s linear infinite;
  }
  @keyframes rotation{
    from{
        -webkit-transform:rotate(0deg);
    }
    to{
        -webkit-transform:rotate(360deg);
    }
  }
  .modal-body{
    padding: 10px
  }
  .link input{
    margin-bottom: 10px
  }
  .rqrcode{
    display: inline-block;
    border: 1px solid #d1d1d1;
    padding: 5px;
    min-width: 150px;
    min-height: 150px;
  }
  .rqrcode img{
    width: 150px;
    height: 150px;
  }
  .body-title{
    margin: 15px 0px;
    font-size: 80%;
  }
  .body-title i{
    font-size: 1.5em;
    vertical-align: middle;
    margin-right: 10px;
  }
</style>
