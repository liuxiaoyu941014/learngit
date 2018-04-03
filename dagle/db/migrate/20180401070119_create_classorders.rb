class CreateClassorders < ActiveRecord::Migration[5.0]
  def change
    create_table :classorders do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.string :name
      t.string :teacher_name
      t.string :weeknu
      t.jsonb :class_day
      t.jsonb :class_time
      t.jsonb :class_place
      t.jsonb :class_week

      t.timestamps
    end
  end
end
