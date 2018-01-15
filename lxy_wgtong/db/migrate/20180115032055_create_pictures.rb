class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.text :pic
      t.text :message_id
      t.text :counts

      t.timestamps
    end
  end
end
