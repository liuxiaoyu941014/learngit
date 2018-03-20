# # 初始创建权限
if Permission.table_exists?
  unless Permission.exists?
    puts "初始创建权限"
    permissions = [
      {symbol_name: 'login_admin', name: '登录后台', group_name: '登录管理', description: ''},
      {symbol_name: 'agent_insert', name: '商家添加', group_name: '商家管理', description: ''},
      {symbol_name: 'agent_update', name: '商家修改', group_name: '商家管理', description: ''},
      {symbol_name: 'agent_delete', name: '商家删除', group_name: '商家管理', description: ''},

      {symbol_name: 'product_insert', name: '产品添加', group_name: '产品管理', description: ''},
      {symbol_name: 'product_update', name: '产品修改', group_name: '产品管理', description: ''},
      {symbol_name: 'product_delete', name: '产品删除', group_name: '产品管理', description: ''}
    ]
    if Settings.project.dagle?
      permissions << {symbol_name: 'login_desktop', name: '登陆桌面端', group_name: '登陆', description: ''}
    elsif Settings.project.imolin?
      permissions += [
        {symbol_name: 'communities_insert', name: '社区添加', group_name: '社区管理', description: ''},
        {symbol_name: 'communities_update', name: '社区修改', group_name: '社区管理', description: ''},
        {symbol_name: 'communities_delete', name: '社区删除', group_name: '社区管理', description: ''},
      ]
    end
    permissions.each do |permission|
      Permission::Create.(permission)
    end
  end
end
