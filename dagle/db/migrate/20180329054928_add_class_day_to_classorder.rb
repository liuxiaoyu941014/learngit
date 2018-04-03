class AddClassDayToClassorder < ActiveRecord::Migration[5.0]
  def change
    add_column :classorders, :class_day, :string
    add_column :classorders, :week, :string
  end
end
