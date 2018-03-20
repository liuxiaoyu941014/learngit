# dagel通用网站系统

## 部署

最新的部署方式，参考 [docker/README.md](docker/README.md)

#### 服务器部署地址：

deployer@prod2uc:/data/www/meikemei/


$ PROJECT_NAME=meikemei bundle exec cap meikemei deploy

#### 测试域名：

http://www.cardzhi.cn/

#### 模板访问地址：

http://www.cardzhi.cn/f7-theme/max_solaris/

#### APP 访问目录：

/mobile

#### APP 安装教程：

https://github.com/xiaohui-zhangxh/vue-webpack-cordova-f7

项目的角色和权限的初始化

１、角色

　　创建初始化角色文件所在位置：　db/seed.rb

　　创建方法：　
```ruby
role_arr = [["product_manager", "产品管理"], ["factory_manager", "厂长"], ["designer", "设计"], ["worker", "工人"], ["purchase", "采购"]]
role_arr.each do |arr|
  Role.find_or_create_by(name: arr[0], role_name: arr[1])
end
```

2、权限

　　创建初始化权限文件所在位置：　config/initializers/initialize_permission.rb

   注意：权限的实现要依赖于文件的配置, 使用方法: user.permission?(权限)

   参照：app/policies/order_policy.rb
