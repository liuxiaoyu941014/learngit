class AddClassDayToClassorders < ActiveRecord::Migration[5.0]
  def change
    add_column :classorders, :class_day, :jsonb
  end
end
