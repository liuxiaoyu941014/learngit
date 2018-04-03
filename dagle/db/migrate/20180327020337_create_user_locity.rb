class CreateUserLocity < ActiveRecord::Migration[5.0]
  def change
    create_table :user_locities do |t|
      t.references :user, foreign_key: true
      t.string :locity
    end
  end
end
