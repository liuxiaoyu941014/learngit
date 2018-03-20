<template>
  <div class="">
    <ol class="breadcrumb samll">
      <li>选择：</li>
      <li v-for="value in breadcrumb">{{ value.name }}</li>
      <span class='empty' v-if='breadcrumb.length > 0'>
        <span @click='onEmpty'><i class="fa fa-remove text-danger"></i></span>
      </span>
    </ol>
    <div class="well well-sm table-responsive">
      <!-- <ol class="list-inline"> -->
        <transition-group name="bounce" tag="ol" class="list-inline">
          <catalog class="black-classify" :key="depth" v-for="(arr, depth) in catalogGroups" :depth="depth" :parent_id="arr[0]" :catalogs="arr[1]" @selected="selected"  :breadcrumb="breadcrumb" :dataUrl="dataUrl" @removeCatalog="removeCatalogGroupsData" :editable="editable" :editicon="editicon" :edithot="edithot"></catalog>
        </transition-group>
      <!-- </ol> -->
    </div>
    <div class="panel-footer text-right" v-if="showConfirmButtons">
      <button type="button" class="btn btn-default" @click="closePanel">取消</button>
      <button type="button" class="btn btn-primary" @click="onSelected">确定</button>
    </div>
  </div>
</template>
<script>
import Catalog from './list'
import 'transitions/bounce';
export default {
  props: {
    dataUrl: { required: true, type: String },
    editable: { type: Boolean, default: true },
    editicon: { type: Boolean, default: false },
    edithot: { type: Boolean, default: false },
    showConfirmButtons: { type: Boolean, default: false },
    default: { type: Array, default: function(){
      return [];
    }}
  },
  components: { Catalog },
  data () {
    return {
      catalogGroups: [],
      breadcrumb: [],
    }
  },
  methods: {
    loadData () {
      var successHandler = function(response){
        this.catalogGroups.push([null, response.body]);
        if ( this.showConfirmButtons && this.default.length > 0){
          this.defaultSelected(this.default)
        }
      }
      var errorHandler = function(response){
        alert('falied')
      }
      this.$http.get(this.dataUrl).then(successHandler, errorHandler);
    },
    selected (catalog, depth) {
      var shouldPush = true;
      if(this.catalogGroups[depth + 1] && this.catalogGroups[depth + 1] == catalog.children){
        shouldPush = false
      }
      if(shouldPush){
        this.catalogGroups.splice(depth + 1);
        if(catalog.children && catalog.children.length > 0){
          this.catalogGroups.push([catalog.id, catalog.children]);
        }
      }
    },
    removeCatalogGroupsData (obj) {
      var depth = parseInt(obj.depth), index = parseInt(obj.catalogIndex)
      if (this.catalogGroups.length > depth) {
        this.catalogGroups[depth][1].splice(index, 1)
        if (this.catalogGroups[depth+1][0] == obj.catalog.id) {
          this.catalogGroups.splice(depth + 1)
        }
      }
    },
    closePanel () {
      this.$emit('closed');
    },
    onSelected () {
      this.$emit('selected', this.breadcrumb);
    },
    defaultSelected(selectedArray){
      this.catalogGroups.splice(1);
      this.breadcrumb = [];
      this.recursive(this.catalogGroups[0][1], selectedArray, 0)
    },
    recursive(catalogGroups, selectedArray, i){
      var _this = this;
      catalogGroups.forEach(function(value){
        if(value.id == selectedArray[i]){
          _this.breadcrumb.push(value)
          value.selected = true;
          _this.selected(value, i)
          _this.recursive(value.children, selectedArray, ++i)
        }
      })
    },
    onEmpty () {
      this.defaultSelected([])
      this.catalogGroups[0][1].forEach(function (v) {
        v.selected = false
      })
      $('.black-classify.black-classify .active').removeClass('active')
    }
  },
  mounted () {
    this.loadData();
  }
}
</script>

<style scoped>
/*.catalog-fixed{
  position: fixed;
  width: 80%;
  left: 10vw;
  top: 5vh;
  z-index: 10000;
  box-shadow: 0px 0px 5px 0px #ccc;
}*/
.well{
  background: #efefef;
  min-width: 100%;
  overflow-x: scroll;
  overflow-y: hidden;
  margin-bottom: 0px;
}
.well ol.list-inline{
  margin: 0px;
  white-space: nowrap;
  display: inline-block;
}
.well ol li.black-classify{
  width: 300px;
  margin-right: 10px;
  background: #fff;
  padding: 0px;
  box-shadow: 0px 0px 5px 0px #c0c7c9;
}
.empty{
  margin: 0px 5px;
  cursor: pointer;
}
</style>
