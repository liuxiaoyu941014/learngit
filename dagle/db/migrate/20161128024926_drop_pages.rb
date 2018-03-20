class DropPages < ActiveRecord::Migration[5.0]
  def change
    drop_table :pages_items
    drop_table :pages
  end
end
