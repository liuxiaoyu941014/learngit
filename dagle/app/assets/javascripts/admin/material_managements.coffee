$(document).ready ()->
  pages = $('body.admin-material_managements')
  if pages.length > 0
    container = pages.find('.choose-material')
    if container.length > 0
      material_management = new Vue
        el: container[0]
        data:
          showModel: false
          materials: []
          materialOutputDetails: []
          selectedAll: false
        computed:
          selectedDetails: ()->
            this.materials.filter((m)->
              return m.selected
            )
        mounted: ()->
          vm = this
          # load data
          vm.$http.get(vm.$el.dataset.url).then((data)->
            data.body.forEach((value)->
              value.number = 1
              value.selected = false
              vm.materials.push(value)
            )
          ,(response)->
          )
        watch:
          selectedAll: (val)->
            if val
              this.materials.forEach((material)->
                material.selected = true
              )
            else
              this.materials.forEach((material)->
                material.selected = false
              )
        methods:
          cancel: ()->
            this.showModel = false
          confirm: ()->
            this.materialOutputDetails = this.selectedDetails
            this.showModel = false
          deleteDetail: (id, index)->
            this.materials.forEach((material)->
              if material.id == id
                material.selected = false
            )
            this.materialOutputDetails.splice(index, 1)




