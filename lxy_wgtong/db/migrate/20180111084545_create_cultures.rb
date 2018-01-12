class CreateCultures < ActiveRecord::Migration[5.1]
  def change
    create_table :cultures do |t|
      t.text :pic1
      t.text :pic2
      t.text :pic3
      t.text :pic4
      t.text :title
      t.text :time
      t.text :place
      t.text :company
      t.text :kind
      t.text :price

      t.timestamps
    end
  end
end
