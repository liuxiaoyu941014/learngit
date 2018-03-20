# 什么是CRM(客户关系管理)

客户关系管理是提供给agent端管理公司营销客户的系统，给客户分类、打标签；记录客户营销日志；进行客户筛选和营销推送。

# 客户关系管理需要做的事情

  - 添加客户
  - 客户分类（各个维度分类）
  - 客户筛查
  - 客户营销历史日志
  - 客户营销页推送
  - 客户短信推送

  涉及Model：

      app/models/member_catalog.rb
      app/models/member.rb
      app/models/member_note.rb

# member_catalog

  <p> 属性value是一个PostgreSQL的array类型， 关于Array的知识点参考： </p>

  [Rails 4 and PostgreSQL Arrays](http://blog.plataformatec.com.br/2014/07/rails-4-and-postgresql-arrays/)

  [How to start using Arrays in Rails with PostgreSQL](http://blog.arkency.com/2014/10/how-to-start-using-arrays-in-rails-with-postgresql/)

  - 插值格式： {A类,B类,C类}
  - Rails返回结果： ["A类", "B类", "C类"]

# 编辑用户标签

  使用插件： [Tokenfield](http://sliptree.github.io/bootstrap-tokenfield/)
