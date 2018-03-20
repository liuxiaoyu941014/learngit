class CreateUserMobiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_mobiles do |t|
      t.references :user, foreign_key: true
      t.string :phone_number

      t.timestamps
    end
  end
end
