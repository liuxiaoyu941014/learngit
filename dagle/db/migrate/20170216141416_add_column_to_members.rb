class AddColumnToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :typo, :string #类型： 正式、非正式
    add_column :members, :from, :string #来源： 店铺、营销页
    add_column :members, :owned, :string #归属： 系统、介绍
  end
end
