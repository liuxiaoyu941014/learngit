<template>
  <!-- modal -->
  <transition name="bounce">
    <div class="catalog-modal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- modal header -->
        <div class="modal-header">
          <button type="button" name="button" class="close" @click='close'>
            <span aria-hidden="true">&times;</span>
            <span class="sr-only">关闭</span>
          </button>
          <h4 class="modal-title modalLabel">{{ options.formStatus == 'new' ? '新建目录' : '修改' }}</h4>
        </div>
        <!-- modal body -->
        <div class="modal-body">
          <div class="form form-horizontal" role="form">
            <div class="form-group">
              <div class="col-sm-2 control-label">名称</div>
              <div class="col-sm-10">
                <input type="text" v-focus @keyup.enter="submit" v-model='model.name' class="form-control" placeholder="输入名称">
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-2 control-label">属性</div>
              <div class="col-sm-10">
                <input type="text" @keyup.enter="submit" v-model='model.settings' class="form-control" placeholder="输入该分类的属性，用逗号隔开！">
              </div>
            </div>
            <div class="form-group" v-show="editicon">
              <div class="col-sm-2 control-label">图标地址</div>
              <div class="col-sm-10">
                <input type="text" @keyup.enter="submit" v-model='model.icon_url' class="form-control" placeholder="输入该分类的图标地址">
              </div>
            </div>
            <div class="form-group" v-show="edithot">
              <div class="col-sm-2 control-label">设为热门服务</div>
              <div class="col-sm-1">
                <input type="checkbox" @keyup.enter="submit" v-model='model.is_hot' class="form-control">
              </div>
            </div>
            <!-- 状态提示信息 -->
            <div class="return_messages text-center" :class="options.responseMessage.status ? 'text-success' : 'text-danger' ">
              {{ options.responseMessage.text}}
            </div>
            <div class="small text-right warn">
              <span>* 目录名称不可重复</span>
            </div>
          </div>
        </div>
        <!-- modal footer -->
        <div class="modal-footer">
          <button type="button" name="button" class="btn btn-default" @click="close">取消</button>
          <button type="button" name="button" class="btn btn-primary" @click="submit">更新</button>
        </div>
      </div>
    </div>
  </div>
  </transition>
</template>
<script>
import 'transitions/bounce';

export default{
  props: {
    options: { type: Object, required: true },
    value: { type: Boolean, default: true },
    editicon: { type: Boolean},
    edithot: { type: Boolean},
    model: { type: Object, required: true }
  },
  data() {
    return{
    }
  },
  methods:{
    close () {
      this.$emit('input', false)
    },
    submit () {
      this.model.parent_id = this.options.parent_id;
      var model = {catalog: this.model, options: this.options };
      if (this.options.formStatus=='new') {
        this.$emit('addSubmit', model)
      }else if (this.options.formStatus=='edit') {
        this.$emit('editSubmit', model)
      }
    }
  }
}
</script>

<style scoped>
.catalog-modal{
  position: fixed;
  top: 30vh;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1050;
  overflow: hidden;
}
</style>
