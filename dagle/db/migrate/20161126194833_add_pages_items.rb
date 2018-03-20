class AddPagesItems < ActiveRecord::Migration[5.0]
  def change
    create_table :pages_items, id: false do |t|
      t.references :page, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
