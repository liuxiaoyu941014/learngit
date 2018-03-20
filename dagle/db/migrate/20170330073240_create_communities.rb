class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.jsonb :features
      t.string :address_line

      t.timestamps
    end
  end
end
