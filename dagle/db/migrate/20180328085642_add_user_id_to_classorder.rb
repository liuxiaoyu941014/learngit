class AddUserIdToClassorder < ActiveRecord::Migration[5.0]
  def change
    add_column :classorders, :user_id, :integer
  end
end
