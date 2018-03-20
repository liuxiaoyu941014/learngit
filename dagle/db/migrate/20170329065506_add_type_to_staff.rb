class AddTypeToStaff < ActiveRecord::Migration[5.0]
  def change
    add_column :staffs, :type, :string
  end
end
