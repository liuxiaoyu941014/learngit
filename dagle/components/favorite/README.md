# Favorite
Short description and motivation.

## 如何使用

在你的model文件中, 加入下面的这一行，配置和收藏夹model的关系:

    class Product < ApplicationRecord
        has_many_favorites
    end

在你的controller文件中, 加入下面3种的任何一种的内容:

    acts_as_favoriteable resource: Product

或者

    acts_as_favoriteable resource: :get_resource_of_favorites

    def get_resource_of_favorites
      Product.find(params[:id])
    end

或者

    acts_as_favoriteable resource: -> { Product.find(params[:id]) }

在你的routes文件中, 加入下面的内容，配置路由:

    resources :products do
      favoriteable
    end

在你的view文件中, 加入下面的类容，就可以在页面显示评论插件:

    <%= render_favorite(@product, path: favorite_product_path) %>

在assets/javascripts/application.js, 加入以下内容，加载js文件； 注意，本插件需要Vue支持，所以也需要加载Vue

    //= require vue
    //= require favorites

在assets/stylesheets/application.css， 加入以下内容，加载评论的样式

    //= require favorites   

在Gemfile中加入以下内容，用以加载插件

    gem 'favorite', path: 'components/favorite'

## 查看使用效果
进入下面的路径中运行程序，可以看到评论插件的效果

    cd test/dummy
    rails s

## 自定义显示
1、页面的自定义显示
   复制components/favorite/app/cells/favorite/entry/show.slim在Rails项目app/cells/favorite/entry/show.slim
   修改show.slim文件可以自定义显示页面

## 如何在自己的代码中收藏或取消收藏

使用这个插件之后，可以通过`User.find(1).favorites`获取用户所有的收藏记录，也可以通过`Product.find(1).favorites`获取产品被谁收藏了。

取消或收藏一个资源，针对用户，方法如下：

    user = User.find(1)
    product = Product.find(1)
    user.favorites.tag_to! product # 收藏
    user.favorites.untag_to! product # 取消收藏
    user.favorites.tagged_to? product # 查询资源是否被用户收藏

取消或收藏一个资源，针对资源，方法如下：

    user = User.find(1)
    product = Product.find(1)
    product.favorites.tag_by! user # 收藏
    product.favorites.untag_to! user # 取消收藏
    product.favorites.tagged_by? user # 查询资源是否被用户收藏

# 测试

本测试需要安装`geckodriver`, 在Mac上安装：`brew install geckodriver`

安装好之后，执行`rspec`

```ruby
gem 'favorite'
```

然后执行:
```bash
$ bundle
```

或者你自己安装:
```bash
$ gem install favorite
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
