class AddColumnsToMembers < ActiveRecord::Migration[5.0]
  def change
    remove_column :members, :gender
    add_column :members, :mobile_phone, :string
    add_column :members, :tel_phone, :string
    add_column :members, :wechat, :string
    add_column :members, :firm, :string
    add_column :members, :address, :string
    add_column :members, :note, :string
    add_column :members, :features, :jsonb
  end
end
