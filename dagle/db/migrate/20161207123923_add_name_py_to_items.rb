class AddNamePyToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :name_py, :string
  end
end
