class RemoveEmailUniqueOnUsers < ActiveRecord::Migration[5.1]
  def up
    remove_index :users, :email
    add_index :users, :email
    add_index :users, :mobile_phone
    add_index :users, :username
  end
  def down
    remove_index :users, :email
    add_index :users, :email, unique: true
    remove_index :users, :mobile_phone
    remove_index :users, :username
  end
end
