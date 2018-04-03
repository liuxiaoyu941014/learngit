class CreateUserCardnu < ActiveRecord::Migration[5.0]
  def change
    create_table :user_cardnus do |t|
      t.references :user, foreign_key: true
      t.string :cardnu
    end
  end
end
