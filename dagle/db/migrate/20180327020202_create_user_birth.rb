class CreateUserBirth < ActiveRecord::Migration[5.0]
  def change
    create_table :user_births do |t|
      t.references :user, foreign_key: true
      t.string :birth
    end
  end
end
