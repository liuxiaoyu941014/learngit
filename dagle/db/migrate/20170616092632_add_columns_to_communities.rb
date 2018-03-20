class AddColumnsToCommunities < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :lng, :decimal, precision: 20, scale: 14
    add_column :communities, :lat, :decimal, precision: 20, scale: 14
  end
end
