class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
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
