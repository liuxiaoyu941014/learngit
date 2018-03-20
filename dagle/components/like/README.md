# Like
给任意资源点赞

## 如何使用

在你的model文件中, 加入下面的这一行，配置和收藏夹model的关系:

    class Product < ApplicationRecord
        has_many_likes
    end


在Gemfile中加入以下内容，用以加载插件

    gem 'like', path: 'components/like'

## 查看使用效果
进入下面的路径中运行程序，可以看到点赞插件的效果

    cd test/dummy
    rails s


## 如何在自己的代码中点赞或取消点赞

使用这个插件之后，可以通过`User.find(1).likes`获取用户所有的点赞记录，也可以通过`Product.find(1).likes`获取产品被谁点赞了。

取消或收藏一个点赞，针对用户，方法如下：

    user = User.find(1)
    product = Product.find(1)
    user.likes.tag_to! product # 点赞
    user.likes.untag_to! product # 取消点赞
    user.likes.tagged_to? product # 查询资源是否被用户点赞

取消或点赞一个资源，针对资源，方法如下：

    user = User.find(1)
    product = Product.find(1)
    product.likes.tag_by! user # 点赞
    product.likes.untag_to! user # 取消点赞
    product.likes.tagged_by? user # 查询资源是否被用户点赞

定制用户model的类名, 默认用户model类为User. 如果需要改变,

则在initialize/setup_like.rb 中加入类名
    Like.user_model_class = "***"

```ruby
gem 'like'
```

然后执行:
```bash
$ bundle
```

或者你自己安装:
```bash
$ gem install like
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
