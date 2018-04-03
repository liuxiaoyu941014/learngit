class DropCalssorders < ActiveRecord::Migration[5.0]
  def change
    drop_table :classorders
  end
end
