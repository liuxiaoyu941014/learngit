class AddUserIdToCmsComment < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_comments, :user_id, :integer
  end
end
