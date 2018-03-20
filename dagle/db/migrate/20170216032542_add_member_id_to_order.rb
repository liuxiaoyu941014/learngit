class AddMemberIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :member_id, :integer
  end
end
