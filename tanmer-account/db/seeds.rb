# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

app = Doorkeeper::Application.
create_with(
  redirect_uri: "https://account.tanmer.com/auth/tanmer/callback",
  scopes: Doorkeeper.configuration.default_scopes.to_a.join(' '),
  oauth_expiration: 2.hours
).
find_or_create_by(name: '账户中心')

raise "First app id should be 1" unless app.id == Doorkeeper::Application::MAIN_ID

Permission.find_or_create_by(app: app, group_name: '系统配置', name: '查看', subject_class: 'SystemSettings', action: 'show')

Permission.find_or_create_by(app: app, group_name: '应用', name: '查看', subject_class: 'Doorkeeper::Application', action: 'show')
Permission.find_or_create_by(app: app, group_name: '应用', name: '添加', subject_class: 'Doorkeeper::Application', action: 'create')
Permission.find_or_create_by(app: app, group_name: '应用', name: '修改', subject_class: 'Doorkeeper::Application', action: 'update')
Permission.find_or_create_by(app: app, group_name: '应用', name: '删除', subject_class: 'Doorkeeper::Application', action: 'destroy')

Permission.find_or_create_by(app: app, group_name: '用户', name: '查看', subject_class: 'User', action: 'show')
Permission.find_or_create_by(app: app, group_name: '用户', name: '添加', subject_class: 'User', action: 'create')
Permission.find_or_create_by(app: app, group_name: '用户', name: '修改', subject_class: 'User', action: 'update')
Permission.find_or_create_by(app: app, group_name: '用户', name: '删除', subject_class: 'User', action: 'destroy')

Permission.find_or_create_by(app: app, group_name: '角色', name: '查看', subject_class: 'Role', action: 'show')
Permission.find_or_create_by(app: app, group_name: '角色', name: '添加', subject_class: 'Role', action: 'create')
Permission.find_or_create_by(app: app, group_name: '角色', name: '修改', subject_class: 'Role', action: 'update')
Permission.find_or_create_by(app: app, group_name: '角色', name: '删除', subject_class: 'Role', action: 'destroy')

# other apps

app = Doorkeeper::Application.
create_with(
  redirect_uri: "https://wxopen.tanmer.com/auth/tanmer/callback",
  scopes: Doorkeeper.configuration.default_scopes.to_a.join(' '),
  oauth_expiration: 2.hours
).
find_or_create_by(name: '微信开放平台')
app.sources.create(source: 'http://localhost:3001')

Permission.find_or_create_by(app: app, group_name: '公众号', name: '查看', subject_class: 'Wxopen::Account', action: 'show')
Permission.find_or_create_by(app: app, group_name: '公众号', name: '添加', subject_class: 'Wxopen::Account', action: 'create')
Permission.find_or_create_by(app: app, group_name: '公众号', name: '修改', subject_class: 'Wxopen::Account', action: 'update')
Permission.find_or_create_by(app: app, group_name: '公众号', name: '删除', subject_class: 'Wxopen::Account', action: 'destroy')

app = Doorkeeper::Application.
create_with(
  redirect_uri: "https://gems.tanmer.com/auth/tanmer/callback",
  scopes: Doorkeeper.configuration.default_scopes.to_a.join(' '),
  oauth_expiration: 2.hours
).
find_or_create_by(name: 'Gem服务器')

Permission.find_or_create_by(app: app, group_name: 'Gem', name: '查看', subject_class: 'Gem', action: 'show')
Permission.find_or_create_by(app: app, group_name: 'Gem', name: '添加', subject_class: 'Gem', action: 'create')
Permission.find_or_create_by(app: app, group_name: 'Gem', name: '修改', subject_class: 'Gem', action: 'update')
Permission.find_or_create_by(app: app, group_name: 'Gem', name: '删除', subject_class: 'Gem', action: 'destroy')

# create default user and role

user = User.create_with(password: 'admin888', name: 'xiaohui', mobile_phone: '15328077520', username: 'xiaohui', image: 'https://gitlab.tanmer.com/uploads/-/system/user/avatar/1/avatar.png').find_or_create_by(email: 'xiaohui@tanmer.com')
role = Role.find_or_create_by(name: '超级管理员')
role.permissions = Permission.all
user.add_role role
