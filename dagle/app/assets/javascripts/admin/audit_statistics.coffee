$(document).ready ()->
  pages = $('body.admin-audits')
  if pages.length > 0
    container = pages.find('#audit-statistics')
    catalog = new Vue
      el: container[0]
      data:
        teamOptions: []
        workerOptions: []
        team: ''
        workers: []
        business: 'Site'
        action: 'create'
        tasks: [{name: '商家管理', value: 'Site'}, {name: '社区管理', value: 'Community'}, {name: '产品管理', value: 'Item'}]
        actions: [{name: '创建', value: 'create'}, {name: '更新', value: 'update'}, {name: '删除', value: 'destroy'}]
        pieChartData: [],
        daterange: ''
      mounted: ()->
        this.loadTeamOptions()
      methods:
        loadTeamOptions: ()->
          _this = this
          $.ajax
            url: '/admin/roles.json'
            type: 'get'
            success: (data)->
              _this.teamOptions = data.admin_roles
              _this.team = _this.teamOptions[0].id
            error: (data)->
              alert('网络错误')
        loadWorkderOptions: ()->
          _this = this
          $.ajax
            url: '/admin/users.json' + '?role_id=' + _this.team
            type: 'get'
            dataType: 'json'
            success: (data)->
              _this.workerOptions = data.results
            error: (data)->
              alert('网络错误')
        teamChange: ()->
          this.loadWorkderOptions()
        drawPieChart: ()->
          _this = this
          nv.addGraph ->
            pieChart = nv.models.pieChart().x((d) ->
              d.label + '(' + d.value + ')'
            ).y((d) ->
              d.value
            ).showLabels(true).labelThreshold(.05)
            $("#nv-pie-chart").text('')
            d3.select('#nv-pie-chart').append('svg').datum(_this.pieChartData).transition().duration(350).call pieChart          
        generateChart: ()->
          _this = this
          if _this.workers.length == 0
            alert('请选择员工')
            return
          $.ajax
            url: '/admin/audits/statistics.json' + '?user_ids=' + _this.workers + '&auditable_type=' + _this.business + '&action_name=' + _this.action + '&daterange=' + _this.daterange
            type: 'get'
            dataType: 'json'
            success: (data)->
              _this.pieChartData = data.audits
              _this.drawPieChart()
            error: (data)->
              alert('网络错误')          