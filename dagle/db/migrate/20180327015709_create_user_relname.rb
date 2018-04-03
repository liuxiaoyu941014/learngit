class CreateUserRelname < ActiveRecord::Migration[5.0]
  def change
    create_table :user_relnames do |t|
      t.references :user, foreign_key: true
      t.string :relname
      t.timestamps
    end
  end
end
