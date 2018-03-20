class VendorRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :vendor_relations do |t|
      t.integer :vendor_id
      t.references :relation, polymorphic: true

      t.timestamps
    end
  end
end
