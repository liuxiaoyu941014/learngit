<template>
  <div>
    <div class="well">
      <ul class="row list-inline">
        <li class="col-sm-12 col-xs-6 col-md-3" v-for="(image, index) in imageList" :key="image.image_url">
          <div class="img-thumbnail">
            <image-upload class="image-slim" 
                          :auto-upload="autoUpload"
                          :name="name"
                          :server="server"
                          v-model="image.id"
                          label=""
                          :image-url="image.image_url"
                          :init-save="image.init_save"
                          @remove="delete_image(image.image_url)"
                          >
            </image-upload>
          </div>
        </li>
        <li class="col-sm-12 col-xs-6 col-md-3">
          <div class="img-thumbnail">
            <div class="bg-gray">
              <div class="add-images-btn file" title="添加本地图片">
                <i class="fa fa-plus fa-2x"></i>
                <input type="file" multiple @change="selectImages($event)">
              </div>
              <h5>选择本地图片</h5>
            </div>
          </div>
        </li>
      </ul>
    </div>

  </div>

</template>

<script>
  
  export default{
    // props: ['name', 'autoUpload', 'server'],
    props: {
      name: {type: String, required: true},
      autoUpload: {type: Boolean, default: true},
      server: {type: String, required: true}
    },
    data() {
      return {
        imageList: []
      }
    },
    methods: {
      selectImages(event){
        var vm = this;
        var files = event.target.files;
        for(var i=0; i<files.length; i++){
          var obj = {};
          obj.image_url = vm.getObjectURL(files[i]);
          obj.init_save = true;
          vm.imageList.push(obj);
        }
      },
      getObjectURL(file){
        var url = null ; 
        if (window.createObjectURL!=undefined) { // basic
          url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) { // mozilla(firefox)
          url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) { // webkit or chrome
          url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
      },
      delete_image(id_or_url){
        var image_index = -1;
        if(typeof(id_or_url) == 'number'){
          image_index = this.get_image_index(id_or_url);
        }else{
          image_index = this.get_image_url_index(id_or_url);
        }
        if(image_index >= 0){
          this.imageList.splice(image_index,1)
        }
      },
      get_image_url_index(url){
        var vm = this;
        for(var i = 0; i< vm.imageList.length; i++)
          if(vm.imageList[i].image_url == url){
            return i;
          }
        return -1;        
      }     
    }
  }

</script>

<style scoped>
  .file {
      position: relative;
      display: inline-block;
      background: #00acac;
      border-color: transparent;
      border-radius: 4px;
      padding: 4px 12px;
      overflow: hidden;
      color: gray;
      text-decoration: none;
      text-indent: 0;
      line-height: 30px;
  }
  .file input {
      position: absolute;
      font-size: 100px;
      right: 0;
      top: 0;
      opacity: 0;
  }
  .file:hover {
      background: skin-color(primary-l);
      border-color: transparent;
      color: #fff;
      text-decoration: none;
  }

  .well{
    margin: 10px auto;
    padding-right: 0px;
  }
  h5{
    color: gray;
  }
  ul.row{
    width: 100%;
    min-height: 300px;
    padding: 0px;
  }
  ul.row li{
    margin: 5px auto;
  }
  ul.row li .img-thumbnail{
    height: 250px;
    width: 100%;
  }
  ul.row li .img-thumbnail:hover{
    box-shadow: 0px 0px 10px -3px #00acac;
  }
  ul.row li .img-thumbnail .image-slim{
    height: 100%;
    overflow: hidden;
  }
  ul.row li .img-thumbnail .bg-gray .add-images-btn{
    margin: 0px auto;
    height: 60px;
    border: 1px solid #ccc;
    width: 60px;
    border-radius: 100%;
    line-height: 60px;
    text-align: center;
    font-size: 20px;
    background: rgba(255,255,255,0.5);
    box-shadow: 0px 0px 0px 5px rgba(167, 156, 156, 0.09);
  }
  ul.row li .img-thumbnail .bg-gray .add-images-btn:hover{
    color: #8ad28b;
  }
  ul.row li .img-thumbnail .bg-gray{
    background: #eeeeee;
    height: 100%;
    width: 100%;
    padding: 45% 0px;
    text-align: center;
  }
  ul.row li .img-thumbnail .bg-gray .add-images-btn i{
    vertical-align: sub;
  }
  .img-thumbnail .add-btn{
    margin-top: 35px;
  }
</style>