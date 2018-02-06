class AddUernameToModels < ActiveRecord::Migration[5.1]
  def change
    add_column :models, :username, :string
  end
end
