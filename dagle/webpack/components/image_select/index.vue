<template>
  <div>
    <div class="well">
      <ul class="row list-inline">
        <li class="col-xs-12 col-sm-6 col-md-4" v-for="(image, index) in imageList" :key="image.image_url">
          <div class="img-thumbnail">
            <image-upload class="image-slim" :auto-upload="true"
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
        <li class="col-xs-12 col-sm-6 col-md-4">
          <div class="img-thumbnail add-images">
            <div class="bg-gray">
              <div class="add-images-btn file" title="添加本地图片">
                <i class="fa fa-plus fa-2x"></i>
                <input type="file" multiple @change="selectImages($event)">
              </div>
              <div class="add-btn text-center">
                <button type="button" class="btn btn-success" @click="showModal = true">选择已上传图片</button>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>

    <modal title="选择图片" :show.sync="showModal" @cancel="showModal = false" okText='保存' cancelText="取消" @ok="showModal = false">
        <div>
          <image-album :server="server" @delete="delete_image" @selected="selected_images" :selected-list="imageListIds"></image-album>
        </div>
    </modal>

  </div>
</template>

<script>
  export default {
    // props: ['server', 'name', 'selectedIds'],
    props: {
      server: {type: String, required: true},
      name: {type: String, required: true},
      selectedIds: {type: String, default: ''}
    },
    data(){
      return {
        showModal: false,
        listServer: '',
        deleteServer: '',
        imageList: []
      }
    },
    computed: {
      imageListIds: function () {
        return this.imageList.map(function(image) {
          return image.id;
        })
      }
    },
    mounted (){
      var vm = this;
      if(vm.selectedIds){
        vm.$http.get(vm.server + '?ids=' + vm.selectedIds).then((data) => {
          if(data.body.image_items)
            vm.imageList = data.body.image_items;
        }, (response) => {
            // error callback
        });
      }

    },
    methods: {
      selected_images(image){
        if(this.imageListIds.indexOf(image.id) >= 0){
          this.delete_image(image.id);
        }else{
          this.imageList.push(image);
        }
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
      get_image_index(id) {
        var vm = this;
        for(var i = 0; i< vm.imageList.length; i++)
          if(vm.imageList[i].id == id){
            return i;
          }
        return -1;
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
      /*background: #00acac;*/
      border-color: transparent;
      /*border-radius: 4px;*/
      /*padding: 4px 12px;*/
      overflow: hidden;
      /*color: #fff;*/
      text-decoration: none;
      text-indent: 0;
      /*line-height: 30px;*/
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
  ul.row{
    width: 100%;
    min-height: 300px;
    padding: 0px;
  }
  ul.row li{
    margin: 5px auto;
  }
  ul.row li .img-thumbnail{
    height: 30vh;
    width: 100%;
  }
  ul.row li .img-thumbnail:hover{
    box-shadow: 0px 0px 10px -3px #00acac;
  }
  ul.row li .img-thumbnail .add-images{
    padding: 5% 0;
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
    padding: 10% 0;
    text-align: center;
  }
  ul.row li .img-thumbnail .bg-gray .add-images-btn i{
    vertical-align: sub;
  }
  .img-thumbnail .add-btn{
    margin-top: 35px;
  }
</style>
