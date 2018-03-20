<template>
  <div class="image_items">
    <div class="gallery-option-set" id="filter" data-option-key="filter">
      <a class="btn btn-default btn-xs" @click="load_images(currentPage,'')">
          所有
      </a>
      <a v-for="tag in tagList"  class="btn btn-default btn-xs" @click="load_images(currentPage,tag)">
          {{tag}}
      </a>
    </div>
    <div id="gallery" class="gallery">
      <transition-group name="list" tag="div">
        <div class="col-xs-12 col-sm-6 col-md-4" v-for="image in imageList" :key="image.id">
          <div class="image">
            <div class="image-inner">
              <img :src="image.image_url" alt="" @click="choose_image(image)"/>
              <span class="fa fa-check selected" v-show="selectedList.indexOf(image.id) != -1"></span>
              <span class="fa fa-close remove" @click="delete_image(image.id)"></span>
            </div>
          </div>
          <div class="image-info">
            <div class="input-group">
              <input type="text" class="form-control" v-model="image.tags" placeholder="图片标签，用逗号分开">
              <span class="input-group-btn">
                <button class="btn btn-default" type="button" @click="save_tag(image)">保存</button>
              </span>
            </div>
          </div>
        </div>
      </transition-group>
    </div>

      <div class="row">
        <div class="col-sm-5">
          <div class="dataTables_info" id="data-table_info" role="status" aria-live="polite">
          </div>
        </div>
        <div class="col-sm-7">
          <div class="dataTables_paginate paging_simple_numbers" id="data-table_paginate">
            <ul class="pagination">
              <li class="paginate_button previous" :class="currentPage-1 <= 0 ? 'disabled' : '' " id="data-table_previous" @click="load_images(currentPage-1)">
                <span aria-controls="data-table" data-dt-idx="0" tabindex="0">
                  上一页
                </span>
              </li>
              <li :class="['paginate_button', n==currentPage ? 'active' : '']" v-for="n in totalPage" v-if="(currentPage-3) < n && n < (currentPage+3)" @click="load_images(n)">
                <span  aria-controls="data-table" :data-dt-idx="n" tabindex="0">{{n}}</span>
              </li>
              <li class="paginate_button next" :class="currentPage+1 > totalPage ? 'disabled' : '' " id="data-table_next" @click="load_images(currentPage+1)">
                <span href="#" aria-controls="data-table" :data-dt-idx="currentPage+1" tabindex="0">下一页</span>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    // props: ['server', 'deleteServer', 'selectedList'],
    props: {
      server: {type: String, required: true},
      selectedList: {
        type: Array,
        default: function(){
          return []
        }
      }
    },
    data () {
      return {
        imageList: [],
        tagList: [],
        totalPage: 1,
        currentPage: 1
      }
    },
    mounted() {
      this.load_images(1);
    },
    methods: {
      load_images(page,tag_name=null) {
        var vm = this
        vm.$http.get(vm.server, {params: {tag: tag_name, page: page}}).then((data) => {
          vm.currentPage = page;
          vm.imageList = data.body.image_items;
          vm.tagList = data.body.tags;
          vm.totalPage = data.body.total_page;
        }, (response) => {
            // error callback
        });
      },
      choose_image(image) {
        this.$emit('selected', image);
      },
      delete_image(id) {
        var vm = this;
        if(window.confirm('确定要删除吗?')){
          vm.$http.delete(this.server+'/'+id).then((data) => {
            var image_index = vm.get_image_index(id);
            if(image_index != -1){
              vm.imageList.splice(image_index, 1)
            }
            vm.$emit('delete', id);
          }, (response) => {
              // error callback
          });
        }
      },
      get_image_index(id) {
        var vm = this;
        for(var i = 0; i< vm.imageList.length; i++)
          if(vm.imageList[i].id == id){
            return i;
          }
        return -1;
      },
      save_tag (image) {
        var vm = this
        vm.$http.put(vm.server+'/'+image.id, {tag: image.tags}).then((data) => {
          console.log(data)
        }, (response) => {
            // error callback
        });
      }
    }
  }
</script>

<style scoped>
  .image_items{
    height: 100%;
  }
  .gallery {
      margin: 0px;
      overflow: hidden;
      overflow-y: scroll;
      height: 90%;
  }

  .gallery .image img {
    width: 100%;
    height: 200px;
    -webkit-border-radius: 3px 3px 0 0;
    -moz-border-radius: 3px 3px 0 0;
    border-radius: 3px 3px 0 0;
  }

  img {
    vertical-align: middle;
  }

  .gallery-option-set{
    margin: 3px 15px;
  }
  .gallery .col-xs-12{
    margin-top: 5px;
  }
  .gallery .image{
    width: 100%;
  }
  .gallery .img-thumbnail{
    width: 100%;
  }
  .gallery .img-thumbnail:hover{
    box-shadow: 0px 0px 10px -3px #00acac;
    cursor: pointer;
  }
  .gallery .img-thumbnail img{
    width: 100%;
  }
  .gallery .image-inner {
    position: relative;
    background: #fff;
    -webkit-border-radius: 3px 3px 0 0;
    -moz-border-radius: 3px 3px 0 0;
    border-radius: 3px 3px 0 0;
    text-align: center;
    overflow: hidden;
    width: 100%;
    /*height: 250px;*/
  }

  .gallery .image-inner .selected{
    position: absolute;
    top: 10px;
    left: 10px;
    color: #fff;
    height: 20px;
    width: 20px;
    line-height: 20px;
    font-size: 14px;
    background-color: rgba(64,183,66,0.8);
    border-radius: 10px;
  }

  .gallery .image-inner .remove{
    position: absolute;
    top: 10px;
    right: 10px;
    color: #a94442;
    height: 20px;
    width: 20px;
    line-height: 20px;
    font-size: 14px;
    background-color: rgba(255,255,255,0.15);
    border-radius: 10px;
  }
  .gallery .image-inner .remove:hover{
    background-color: rgba(255,255,255,0.3);
    cursor: pointer;
  }
  .gallery .image a {
      -webkit-transition: all .2s linear;
      -moz-transition: all .2s linear;
      transition: all .2s linear;
  }
  .gallery .image a:hover,
  .gallery .image a:focus {
      opacity: 0.8;
      filter: alpha(opacity=80);
  }
  .gallery .image-caption {
      position: absolute;
      top: 15px;
      left: 0;
      /*background: url(./img/black6.png);*/
      background: rgba(0,0,0,0.6);
      color: #fff;
      padding: 5px 15px;
      margin: 0;
  }
  .gallery .image-info {
      background: #fff;
      padding: 15px;
      -webkit-border-radius: 0 0 3px 3px;
      -moz-border-radius: 0 0 3px 3px;
      border-radius: 0 0 3px 3px;
  }
  .gallery .image-info .title {
      margin: 0 0 10px;
      line-height: 18px;
      font-size: 14px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
  }
  .gallery .image-info .rating {
      line-height: 20px;
      margin: 0 0 3px;
  }
  .gallery .image-info .desc {
      line-height: 16px;
      font-size: 12px;
      height: 48px;
      overflow: hidden;
  }
  .gallery .rating span.star {
      font-family: FontAwesome;
      display: inline-block;
  }
  .gallery .rating span.star:before {
      content: "\f005";
      color: #999;
  }
  .gallery .rating span.star.active:before {
      color: #FF8500;
  }

  .list-enter-active, .list-leave-active {
    transition: all 0.5s;
  }
  .list-enter, .list-leave-active {
    opacity: 0;
    transform: translateY(30px);
  }

</style>
