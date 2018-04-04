def crud_actions
  action :create, title: '添加'
  action :update, title: '更新'
  action :destroy, title: '删除'
  action :show, title: '查看'
end
Permission::Definition.config do
  permission :site do
    title '商家'
    description '每个商家下面可以有子商家'
    resource_class 'Site'
    closure_tree_parent :parent
    closure_tree_children :children
    crud_actions
    child :product do
      title '产品'
      resource_class 'Product'
      parent_relations site: :products
      action :update do
        title '更新'
        description '更新产品信息'
      end
      child :article do
        resource_class 'Article'
        parent_relations product: :articles
        crud_actions
      end
      child :image do
        title '图片附件'
        resource_class 'ImageAttachement'
        parent_relations owner: :images
        crud_actions
      end
    end
  end
  permission :comment do
    title '用户对商家的评论'
    resource_class 'Comment'
    crud_actions
    action :audit, title: '审核'
  end
end and nil

Permission::Definition.list

Permission::Path.parse('site/product#create')
Permission::Path.parse('site/product#destroy')
Permission::Path.parse('site/product#-destroy#1')
# site/comment#create
# comment#update#10
# site#create
# site##1/product#


----------

Permission.