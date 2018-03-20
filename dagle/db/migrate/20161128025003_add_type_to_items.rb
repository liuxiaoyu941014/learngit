class AddTypeToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :type, :string, after: :id
  end
end
