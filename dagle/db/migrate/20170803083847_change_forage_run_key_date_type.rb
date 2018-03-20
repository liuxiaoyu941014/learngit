class ChangeForageRunKeyDateType < ActiveRecord::Migration[5.0]
  def change
    change_column :forage_run_keys, :date, :date
  end
end
