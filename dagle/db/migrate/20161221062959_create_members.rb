class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true
      t.string :name
      t.integer :gender
      t.date :birth
      t.string :qq
      t.string :email

      t.timestamps
    end
  end
end
