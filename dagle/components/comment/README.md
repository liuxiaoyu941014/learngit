# Comment
Short description and motivation.

## 如何使用

在你的model文件中, 加入下面的这一行，配置和评论model的关系:

    class Post < ApplicationRecord
        has_many_comments
    end

在你的controller文件中, 加入下面3种的任何一种的内容:

    acts_as_commentable resource: Post
    
或者
    
    acts_as_commentable resource: :get_resource_of_comments

    def get_resource_of_comments
      Post.find(params[:id])
    end
    
或者
    
    acts_as_commentable resource: -> { Post.find(params[:id]) }

在你的routes文件中, 加入下面的内容，配置路由:

    resources :posts do
      commentable
    end

在你的view文件中, 加入下面的类容，就可以在页面显示评论插件:

    <%= render_comments(resource, path: comments_post_path ) %>

在assets/javascripts/application.js, 加入以下内容，加载js文件； 注意，本插件需要Vue支持，所以也需要加载Vue

    //= require vue
    //= require comments

在assets/stylesheets/application.css， 加入以下内容，加载评论的样式

    //= require comments   

在Gemfile中加入以下内容，用以加载插件

    gem 'comment', path: 'components/comment'

## 查看使用效果
进入下面的路径中运行程序，可以看到评论插件的效果

    cd spec/dummy
    rails s

## 自定义显示
1、页面的自定义显示
   复制components/comment/app/cells/comment/entry/show.slim在Rails项目app/cells/comment/entry/show.slim
   修改show.slim文件可以自定义显示页面


2、修改评论的JSON返回数据（可以修改你需要显示的哪些内容）
   在插件的components/comment/app/concerns/comment/entries_controller_concern.rb中有默认的`comment__entry_json`，需要第定义的话，就在对应的controller中添加这个方法去覆盖默认的定义：

    def comment__entry_json(entry, page = nil)
      comment_info = {}
      comment_info[:comments] =  entry.as_json(only: [:id, :content, :created_at], include: {parent: {only: [:id, :content, :created_at]}} )
      if entry.try(:total_pages)
        comment_info[:total_pages] = entry.total_pages
        comment_info[:current_page] = entry.current_page
      end
      return comment_info
    end


# 测试

本测试需要安装`geckodriver`, 在Mac上安装：`brew install geckodriver`

安装好之后，执行`rspec`

```ruby
gem 'comment'
```

然后执行:
```bash
$ bundle
```

或者你自己安装:
```bash
$ gem install comment
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
