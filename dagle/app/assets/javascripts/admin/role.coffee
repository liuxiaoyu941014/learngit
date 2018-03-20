$(document).ready ->
  bodyEdit = $('.admin-roles.edit_permission')
  blockEle = $('[rel="permission-block"]')
  if bodyEdit.length > 0 and blockEle.length > 0
    url       = blockEle.data('url')
    permissions = blockEle.data('permission')
    clickstatus = blockEle.data('status')
    checked     = blockEle.data('checked')

    loadPermissions = ->
      app._data.allPermission = permissions
      app._data.clickStatus = clickstatus
      app._data.permission_ids = checked

    app = new Vue
      el: "[rel='permission-block']"
      data:
        allPermission: []
        clickStatus: {}
        deletePermission: []
        newPermission: []
        permission_ids: []
      methods:
        checkAll: (values, group_name) ->
          if (this.clickStatus[group_name] == false)
            values.forEach (value) =>
              this.permission_ids.push(value.id)
            this.clickStatus[group_name] = true
          else
            this.deletePermission = []
            this.newPermission = []
            values.forEach (value) =>
              this.deletePermission.push(value.id)
            this.permission_ids.forEach (id) =>
              unless (this.deletePermission.includes(id))
                this.newPermission.push(id)
            this.permission_ids = this.newPermission 
            this.clickStatus[group_name] = false
        postPermission: () ->
          $.ajax
            url: url
            type: 'put'
            data: 
              'permission_ids': this.permission_ids
            success: (data)->
              if data.status == 'failed'
                $.gritter.add({title: '提示', text: data.message})
            error: (data)->
              alert('网络错误')

    loadPermissions()