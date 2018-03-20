<template>
  <div>
    <input type="file" :name="name"/>
    <input type="hidden" :name="name" :value="value">
    <img :src="imageUrl" v-if="value">
  </div>
</template>

<script>
  import Slim from './slim.commonjs'
  export default {
    // props: ['name', 'autoUpload', 'server', 'imageUrl', 'value'],
    props: {
      name: {type: String, required: true},
      autoUpload: {type: Boolean, default: true},
      server: {type: String, required: true},
      value: {type: Number},
      imageUrl: {type: String},
      label: {type: String, default: '选择图片'}
    },
    data () {
      return {
         cropper: null,
      }
    },
    mounted (){
      var vm = this;

      // $(".well .img-thumbnail ").height()

      this.cropper = new Slim(vm.$el, {
        service:  vm.server || '/image_items',
        push: vm.autoUpload,
        label: vm.label,
        buttonConfirmLabel: '确定',
        buttonCancelLabel: '取消',
        maxFileSize: 1,
        willRemove: function(slim, remove){
          if (window.confirm("确定要删除吗？")) {
            remove();
          }
        },
        didRemove: function(data){
          vm.$emit('remove');
        },
        didUpload: function(error, data, response){
          if(error){
            //error
          }else{
            vm.$emit('input', response);  
          }
        },
        didTransform: function(){
          setTimeout(function(){
            $(vm.$el).find('.slim-area .slim-result .out').animate({'opacity': '0'}, 1000)
          },100)
        }
      });
      if(vm.imageUrl && !vm.value) this.cropper.load(vm.imageUrl)
    }
  }
</script>

<style src="./slim.min.css">
</style>
