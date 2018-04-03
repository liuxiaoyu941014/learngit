class AddDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :relname, :string
    add_column :users, :cardnu, :string
    add_column :users, :birth, :string
    add_column :users, :locity, :string
    add_column :users, :sex, :string
  end
end
