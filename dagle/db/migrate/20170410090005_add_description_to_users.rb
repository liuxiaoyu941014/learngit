class AddDescriptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :string, limit: 500
  end
end
