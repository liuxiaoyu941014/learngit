class CreateUserSex < ActiveRecord::Migration[5.0]
  def change
    create_table :user_sexes do |t|
      t.references :user, foreign_key: true
      t.string :sex
    end
  end
end
