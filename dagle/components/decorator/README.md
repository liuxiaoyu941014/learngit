# Decorator
Model修饰工具Decorator

## Usage

    rails g decorator Thing
          create  app/decorators/thing_decorator.rb
          invoke  rspec
          create    spec/decorators/thing_spec.rb

## Installation
Add this line to your application's Gemfile:

`gem 'decorator'`

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install decorator

## 如何使用

继承`Decorator::Base`之后，提供了3个方法：

- object => 获得decorate的对象
- h => helper的快捷方式，如创建html标签，则 `h.content_tag(:p, "Hello world!")`
- r => router的快捷方式，如获得一个链接，则`r.root_path`

Model中可以用`User.all.decorate`获得decorate之后的数组

Controller中可以用`decorate(@user)`获得`@user` decorate 之后的实例

## Testing

put `require 'decorator/rspec'` in `spec/rails_helper.rb`

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
