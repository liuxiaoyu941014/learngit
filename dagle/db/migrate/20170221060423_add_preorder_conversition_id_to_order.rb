class AddPreorderConversitionIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :preorder_conversition_id, :integer
  end
end
