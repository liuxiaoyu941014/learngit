class AddHeadshotToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :headshot, :string
  end
end
