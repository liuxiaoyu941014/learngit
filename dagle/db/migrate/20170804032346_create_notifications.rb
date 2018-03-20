class CreateNotifications < ActiveRecord::Migration[5.0]
  # user_id: 收到通知的用户
  # actor_id: 触发通知的用户
  # notify_type: 通知类型
  # target: 针对触发的对象
  # target_url: 针对触发的对象url
  # target_name: 针对触发的对象的名称
  # second_target: 针对触发的二级对象
  # second_target_url: 针对触发的二级对象url
  # second_target_name: 针对触发的二级对象的名称
  # third_target: 针对触发的三级对象
  # third_target_url: 针对触发的三级对象url
  # third_target_name: 针对触发的三级对象的名称
  # content: 具体内容
  # read_at: 阅读时间
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :actor_id
      t.string :notify_type, null: false
      t.references :target, polymorphic: true
      t.string :target_url
      t.string :target_name
      t.references :second_target, polymorphic: true
      t.string :second_target_url
      t.string :second_target_name
      t.references :third_target, polymorphic: true
      t.string :third_target_url
      t.string :third_target_name
      t.string :content
      t.datetime :read_at

      t.timestamps
    end
  end
end
